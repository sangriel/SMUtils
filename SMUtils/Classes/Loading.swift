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
        if loadingWindow == nil {
            loadingWindow = LoadingWindow(frame: UIScreen.main.bounds)
        }
        loadingWindow!.rootViewController = LoadingView(color: color)
        loadingWindow!.isHidden = false
        
    }
    
    
    public func hide(){
        loadingWindow?.isHidden = true
        
    }
    
}
