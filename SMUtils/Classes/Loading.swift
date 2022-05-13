//
//  Loading.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit


public class Loading {
    public static let global = Loading()
    private init(){}
    
    
    
    public var color : UIColor = .black
    
    private var loadingWindow : LoadingWindow?
    
    
    public func show(){
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            print("noscene")
            return
        }
        
        if loadingWindow == nil {
            loadingWindow = LoadingWindow(windowScene: scene)
        }
        
        loadingWindow!.rootViewController = LoadingView(color: color)
        loadingWindow!.isHidden = false
        
    }
    
    
    public func hide(){
        loadingWindow?.isHidden = true
        
    }
    
}
