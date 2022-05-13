//
//  LoadingWindow.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/13.
//

import Foundation
import UIKit



class LoadingWindow : UIWindow {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.windowLevel = UIWindow.Level.normal
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
