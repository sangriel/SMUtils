//
//  FunctionClass.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit
import CoreLocation
import Photos



public class FunctionClass {
    public static let shared = FunctionClass()
    private init(){}
    
    
    public func modifyStringImageurl(src : String) -> [String] {
        let edited = src
        let editedarray = edited.split(separator: ",")
        var final : [String] = []
        for modifying in editedarray {
            var t = String(modifying)
            t = t.replacingOccurrences(of: "\"", with: "")
            t = t.replacingOccurrences(of: "[", with: "")
            t = t.replacingOccurrences(of: "]", with: "")
            t = t.replacingOccurrences(of: "\\", with: "")
            
            final.append(t)
        }
        return final
    }
    
    public func getLocalTime(time : String, Dateformatter : String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = Dateformatter
        dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        let time1 = dateformatter.date(from: time)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = Dateformatter
        dateFormatter2.timeZone = TimeZone.current
        dateFormatter2.locale = Locale.current // Change "en" to change the default locale if you want
        guard let t = time1 else {
            let date = Date()
            return dateFormatter2.string(from: date)
        }
        let stringDate = dateFormatter2.string(from: t)
        
        return stringDate
    }
    
    
    public func calculateDistance(myLat : Double, myLon : Double, lat : Double, lon : Double) -> Double{
        let mycoordinate = CLLocation(latitude: myLat, longitude: myLon)
        var distanceInMeters : Double = 0
        let coordinate = CLLocation(latitude: lat, longitude: lon)
        distanceInMeters = mycoordinate.distance(from: coordinate)
        
        if lat == 37 && lon == 127 {
            return -1
        }
        else {
            return distanceInMeters / 1000
        }
    }
    
    public func checkUserPushGranted(completion : @escaping (Bool) -> ()) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                completion(false)
            } else if settings.authorizationStatus == .denied {
                completion(false)
            } else if settings.authorizationStatus == .authorized {
                completion(true)
            }
        })
    }
    
    
    public func checkCameraUsageGranted() -> Bool{
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch authStatus {
        case .authorized : return true
        case .denied: return false
        case .notDetermined: return false
        default: return false
        }
    }
    
    public func checkLibraryUsageGranted() -> Bool {
        let state = PHPhotoLibrary.authorizationStatus()
        switch state {
        case .notDetermined, .restricted,.denied,.limited:
            return false
        case .authorized:
            return true
        @unknown default:
            return false
        }
    }
    
    
    public func getUIImage(asset: PHAsset,completion : @escaping(UIImage?) -> () ) {
        
        var img: UIImage?
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .current
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        manager.requestImageDataAndOrientation(for: asset, options: options) { (data, string, _, _) in
            if let data = data{
                img = UIImage(data: data)
                completion(img)
            }
            else {
                completion(nil)
            }
        }
    }
    
    
    
}
