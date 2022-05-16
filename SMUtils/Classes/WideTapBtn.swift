//
//  WideTapBtn.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit

public class WideTapBtn: UIButton {
    
    
    private var inset : CGFloat = -10
    /**
     마이너스로 써라
     */
    public convenience init(inset : CGFloat = -10){
        self.init()
        self.inset = inset
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }
     
        let touchRect = bounds.insetBy(dx: inset, dy: inset)
        if touchRect.contains(point) {
            for subview in subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitTestView = subview.hitTest(convertedPoint, with: event) {
                    return hitTestView
                }
            }
     
            return self
        }
     
        return nil
    }
}

