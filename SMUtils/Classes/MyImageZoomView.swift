//
//  MyImageZoomView.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit
import Lightbox



public class MyImageZoomView :  LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {
    
    weak var viewcontroller : UIViewController?
    
    
    init(viewcontroller : UIViewController){
        self.viewcontroller = viewcontroller
    }
    
    public func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)
    }
    
    public func lightboxControllerWillDismiss(_ controller: LightboxController) {
        
    }
    
    public func showimagezoomview(index : Int, images : [UIImage]){

        var imagsrc : [LightboxImage] = []
        for image in images {
            imagsrc.append(LightboxImage(image: image))
        }
        LightboxConfig.CloseButton.image = UIImage(named: "x")
        LightboxConfig.CloseButton.text = ""
        //LightboxConfig.CloseButton.
        let controller = LightboxController(images: imagsrc, startIndex: index)
        controller.pageDelegate = self
        controller.dismissalDelegate = self
        controller.dynamicBackground = true
        controller.modalPresentationStyle = .fullScreen
        self.viewcontroller!.modalPresentationStyle = .fullScreen
        self.viewcontroller!.modalTransitionStyle = .coverVertical
        self.viewcontroller!.present(controller, animated: true, completion: nil)
        
    }
    
    public func showimagezoomview(index: Int, images : [String]) {
        var imagesrc : [LightboxImage] = []
        
        for image in images {
            let url = URL(string: image)
            imagesrc.append(LightboxImage(imageURL: url!))
        }
        
        LightboxConfig.CloseButton.image = UIImage(named: "x")
        LightboxConfig.CloseButton.text = ""
        //LightboxConfig.CloseButton.
        let controller = LightboxController(images: imagesrc, startIndex: index)
        controller.pageDelegate = self
        controller.dismissalDelegate = self
        controller.dynamicBackground = true
        controller.modalPresentationStyle = .fullScreen
        self.viewcontroller!.modalPresentationStyle = .fullScreen
        self.viewcontroller!.modalTransitionStyle = .coverVertical
        self.viewcontroller!.present(controller, animated: true, completion: nil)
        
    }
}
