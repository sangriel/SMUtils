//
//  ToastWindow.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/13.
//

import Foundation
import UIKit


class ToastWindow : UIWindow {

    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        self.backgroundColor = .clear
        self.windowLevel = UIWindow.Level.normal + 1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
