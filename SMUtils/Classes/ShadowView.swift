//
//  ShadowView.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit



public class ShadowView: UIView {
    
    
    var shadowcolor = UIColor()
    var shadowradius : CGFloat = 0
    var shadowopacity : Float = 0
    var shadowoffset = CGSize()
    
    public override func didMoveToWindow() {
        self.layer.shadowColor = shadowcolor.cgColor
        self.layer.shadowRadius = shadowradius
        self.layer.shadowOpacity = shadowopacity
        self.layer.shadowOffset = shadowoffset
        
    }
    
    
}

