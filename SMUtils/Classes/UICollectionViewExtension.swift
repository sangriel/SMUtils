//
//  UICollectionViewExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func textwidth(for text : String,font : (CGFloat, UIFont.Weight) , height : CGFloat) -> CGFloat {
        let nsstring = NSString(string: text)
        let maxwidth = CGFloat(200)
        let textAttribute = [NSAttributedString.Key.font :  UIFont.systemFont(ofSize: font.0, weight: font.1)]
        let boundingRect = nsstring.boundingRect(with: CGSize(width: maxwidth, height: height), options: .usesLineFragmentOrigin, attributes: textAttribute, context: nil)
        return ceil(boundingRect.width) < maxwidth ? ceil(boundingRect.width) : maxwidth
    }
    
    func textheight(for text : String,font : (CGFloat, UIFont.Weight) , width : CGFloat) -> CGFloat {
        let nsstring = NSString(string: text)
        let maxheight = CGFloat(200)
        let textAttribute = [NSAttributedString.Key.font :  UIFont.systemFont(ofSize: font.0, weight: font.1)]
        
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxheight), options: .usesLineFragmentOrigin, attributes: textAttribute, context: nil)
        return ceil(boundingRect.height) < maxheight ? ceil(boundingRect.height) : maxheight
    }
    
}
