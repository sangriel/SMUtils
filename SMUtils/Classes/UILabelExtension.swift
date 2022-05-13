//
//  UILabelExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit


public extension UILabel {
    func addCharacterSpacing(kernValue: Double) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            self.text = ""
            self.attributedText = attributedString
            
        }
    }
    func setLineHeight(lineHeight: CGFloat,kerval : Double) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            if attributeString.length != 0 {
                attributeString.addAttribute(NSAttributedString.Key.kern, value: kerval, range: NSRange(location: 0, length: attributeString.length - 1))
            }
            
            //style.lineSpacing = linespace
            style.minimumLineHeight = lineHeight
            style.maximumLineHeight = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
    func setattributedlineheigh(lineHeight: CGFloat,kerval : Double) {
        let text = self.attributedText as? NSMutableAttributedString
        self.attributedText = nil
        if let text = text {
            let attributeString = text
            let style = NSMutableParagraphStyle()
            
            attributeString.addAttribute(NSAttributedString.Key.kern, value: kerval, range: NSRange(location: 0, length: attributeString.length - 1))
            //style.lineSpacing = linespace
            
            style.maximumLineHeight = lineHeight
            
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.length))
            self.attributedText = attributeString
        }
    }
    
    func countAnimation(from : Double , upto: Double, duration : Double, unit : String) {
        let steps: Double = 200.0
        let duration = duration
        let rate = Double(duration) / Double(steps)
        let diff = upto - from
        for i in 0...Int(steps) {
            DispatchQueue.main.asyncAfter(deadline: .now() + rate * Double(i)) {
                self.text = "\(Int(from + diff * (Double(i) / steps)))" + unit
            }
        }
    }
    
}

