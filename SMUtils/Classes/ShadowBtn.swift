//
//  ShadowBtn.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit



public class ShadowBtn : UIButton {
    
    
    var shadowcolor : UIColor = .darkGray
    var shadowradius : CGFloat = 4
    var shadowopacity : Float = 0.5
    var shadowoffset : CGSize = CGSize(width: 0, height: 3)
    
    public override func didMoveToWindow() {
        self.layer.shadowColor = shadowcolor.cgColor
        self.layer.shadowRadius = shadowradius
        self.layer.shadowOpacity = shadowopacity
        self.layer.shadowOffset = shadowoffset
        
    }
}


