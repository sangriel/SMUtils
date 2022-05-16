//
//  MyImagePicker.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit
import PhotosUI
import CropViewController
import YangMingShan


public protocol MyImagePhotoPickerDelegate : NSObjectProtocol {
    func imageoutput(image : [UIImage])
}

public class MyImagePhotoPicker : NSObject {
    
    
    
    weak var delegate : MyImagePhotoPickerDelegate?
    weak var viewcontroller : UIViewController?
    private var blockCropView = false
    private let camerapicker = UIImagePickerController()
    private var imagesforOutPut : [UIImage] = []
    private var maxImagecount = 0
    private var currentImageCount = 0
    
    public init(viewcontroller : UIViewController, delegate : MyImagePhotoPickerDelegate){
        super.init()
        self.viewcontroller = viewcontroller
        self.delegate = delegate
        camerapicker.delegate = self
    }
    
    
    private func checkPermission() -> Bool{
        let cameraGranted = FunctionClass.shared.checkCameraUsageGranted()
        let libraryGranted = FunctionClass.shared.checkLibraryUsageGranted()
        
        var title : String = ""
        var message : String = ""
        
        if cameraGranted == false {
            title = "카메라 권한"
            message = "카메라를 사용할 수 있게 권한을 부여해주세요"
        }
        else if libraryGranted == false {
            title = "사진첩 권한"
            message = "인포즈에 사진을 올리 수 있게 사진첩 접근 권한을 부여해주세요"
        }
        
        if libraryGranted && cameraGranted == false {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cAction = UIAlertAction(title: "취소", style: .cancel)
            let confirmAction = UIAlertAction(title: "설정하기", style: .destructive) { _ in
                DispatchQueue.main.async {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
            
            alert.addAction(cAction)
            alert.addAction(confirmAction)
            viewcontroller?.present(alert, animated: false)
            
        }
        return cameraGranted && libraryGranted
    }
    
    
    public enum opentype {
        case library
        case camera
    }
    public func openSheet(maxImageCount : Int, currentImageCount : Int, type : opentype){
        self.maxImagecount = maxImageCount
        self.currentImageCount = currentImageCount
        if self.checkPermission() == false {
            return
        }
        
        if type == .library {
            self.openLibrary()
        }
        else {
            self.openCamera()
        }
        
    }
    
    private func openCamera(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            camerapicker.sourceType = .camera
            camerapicker.showsCameraControls = true
            viewcontroller!.present(camerapicker, animated: false, completion: nil)
        }
        else {
            print("camera not available")
        }
    }
    
    
    private func showPhPermissionPopUp(){
        if #available(iOS 14, *) {
            let requiredAccessLevel: PHAccessLevel = .readWrite
            PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
                switch authorizationStatus {
                case .limited:
                    print("limited authorization granted")
                case .authorized:
                    print("authorization granted")
                default: //FIXME: Implement handling for all authorizationStatus
                    DispatchQueue.main.async {
                        Toasty.global.show(msg: "권한을 허용해주세요")
                    }
                }
            }
        }
    }
    
    let pickerViewController = YMSPhotoPickerViewController.init()
    private func openLibrary(){
        if #available(iOS 14, *) {
            let accessLevel: PHAccessLevel = .readWrite
            let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: accessLevel)
            switch authorizationStatus {
                case .limited, .authorized:
                    var configuration = PHPickerConfiguration()
                    configuration.filter = .any(of: [.images])
                    configuration.selectionLimit = maxImagecount - currentImageCount
                    let picker = PHPickerViewController(configuration: configuration)
                    picker.delegate = self
                    self.viewcontroller!.present(picker, animated: true, completion: nil)
                default:
                    showPhPermissionPopUp()
            }
        }
        else {
            print("something happening?")
            // Fallback on earlier versions
            
            pickerViewController.numberOfPhotoToSelect = UInt(maxImagecount - currentImageCount)
//            pickerViewController.delegate = self
            viewcontroller!.yms_presentCustomAlbumPhotoView(pickerViewController, delegate: self)
        }
    }
    
    
    
    private func openCropViewController(image : UIImage){
        DispatchQueue.main.async { [unowned self] in
            blockCropView = false
            let cropView = CropViewController(image: image)
            cropView.delegate = self
            viewcontroller!.present(cropView, animated: true, completion: nil)
        }
    }
    
    
    
    
}
extension MyImagePhotoPicker : CropViewControllerDelegate {
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        if blockCropView == false {
            cropViewController.dismiss(animated: true) { [unowned self] in
                self.delegate?.imageoutput(image: [image])
            }
            blockCropView = true
        }
    }
    
}
//Camera
extension MyImagePhotoPicker : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            self.openCropViewController(image: image)
        }
        else {
            Toasty.global.show(msg: "잠시 후 시도해 주세요.")
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
    }
}
//YMSPhotoPicker
extension MyImagePhotoPicker : YMSPhotoPickerViewControllerDelegate {
    public func photoPickerViewControllerDidReceivePhotoAlbumAccessDenied(_ picker: YMSPhotoPickerViewController!) {
        print("denied")
    }
    
    public func photoPickerViewControllerDidReceiveCameraAccessDenied(_ picker: YMSPhotoPickerViewController!) {
        print("denied")
    }
    public func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPicking image: UIImage!) {
        picker.dismiss(animated: true, completion: nil)
        blockCropView = false
        self.openCropViewController(image: image)
    }
    public func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPickingImages photoAssets: [PHAsset]!) {
        picker.dismiss(animated: true, completion: nil)
        if photoAssets.count == 1 {
            blockCropView = false
            FunctionClass.shared.getUIImage(asset: photoAssets[0]) { [unowned self] (retrievedImage) in
                if let rimage = retrievedImage {
                    DispatchQueue.main.async { [unowned self] in
                        self.openCropViewController(image: rimage)
                    }
                }
                else {
                    Toasty.global.show(msg: "사진에서 오류가 났습니다")
                }
            }
        }
        else {
            var tempimg : [UIImage] = []
            for img in photoAssets {
                FunctionClass.shared.getUIImage(asset: img) { (retrievedImage) in
                    if let rimage = retrievedImage {
                        tempimg.append(rimage)
                    }
                    else {
                        Toasty.global.show(msg: "하나 이상의 사진에서 오류가 났습니다")
                    }
                }
            }
            self.delegate?.imageoutput(image: tempimg)
        }
    }
    
    
    
}

//PHphoto library
@available(iOS 14, *)
extension MyImagePhotoPicker : PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil)
        imagesforOutPut.removeAll()
        var count = 0
        //if only one image selected go to cropviewcontroller
        if results.count == 1 {
            if let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] image , error  in
                    guard let self = self else { return }
                    guard let image = image as? UIImage else { return }
                    self.openCropViewController(image: image)
                }
            }
        }
        else {
            for data in results {
                if data.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    data.itemProvider.loadObject(ofClass: UIImage.self) { image , error  in
                        count += 1
                        if let image = image as? UIImage {
                            self.imagesforOutPut.append(image)
                        }
                        if count == results.count {
                            DispatchQueue.main.async { [unowned self] in
                                self.delegate?.imageoutput(image: self.imagesforOutPut)
                            }
                        }
                    }
                }
            }
        }
    }
}

