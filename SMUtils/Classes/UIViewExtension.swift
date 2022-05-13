//
//  UIViewExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit

public extension UIView {
    func createGradientLayer(color1 : UIColor , color2 : UIColor ,  start :CGPoint , end : CGPoint) {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.name = "gardient"
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        
        //        self.layer.mask = gradientLayer
        self.layer.addSublayer(gradientLayer)
    }
    
    
    func createGradientLayer(colors : UIColor... ,  start :CGPoint, mid : CGPoint, end : CGPoint) {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        self.layer.sublayers?.forEach({ (layer) in
            if layer.name == "gardient" {
                return
            }
        })
        gradientLayer.name = "gardient"
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = colors.map{$0.cgColor}
        gradientLayer.startPoint = start
        gradientLayer.anchorPoint = mid
        gradientLayer.endPoint = end
        
        self.layer.addSublayer(gradientLayer)
    }
    
    func tocircle(){
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint,path : [NSNumber], color : UIColor = .lightGray) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = path //[7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    
    
}
