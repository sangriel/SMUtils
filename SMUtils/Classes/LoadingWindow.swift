//
//  LoadingWindow.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/13.
//

import Foundation
import UIKit



class LoadingWindow : UIWindow {
    
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        self.backgroundColor = .clear
        self.windowLevel = UIWindow.Level.alert + 1
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
