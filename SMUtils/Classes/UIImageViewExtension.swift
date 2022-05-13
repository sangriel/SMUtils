//
//  UIImageViewExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation
import UIKit
import Kingfisher




public extension UIImageView  {
    func imagewithinset(leftcap : CGFloat, image : UIImage) {
        let image = image
        let imagwidth = image.size.width
        let imageheight = image.size.height
        
        let leftcapinset = leftcap * imagwidth
        let rightcapinset = imagwidth - leftcapinset
        let topinset = 0.5 * imageheight
        let bottominset = 0.5 * imageheight
        
        let inset = UIEdgeInsets(top: topinset, left: leftcapinset, bottom: bottominset, right: rightcapinset)
        let imagewithinset = image.resizableImage(withCapInsets: inset, resizingMode: .stretch)
        
        
        self.image = imagewithinset
        
        
    }
    func imagewithverticalinset(topcap : CGFloat , image : UIImage){
        let image = image
        let imagwidth = image.size.width
        let imageheight = image.size.height
        
        let leftcapinset = 0.5 * imagwidth
        let rightcapinset = imagwidth - leftcapinset
        let topinset = topcap * imageheight
        let bottominset = imageheight - topinset
        
        let inset = UIEdgeInsets(top: topinset, left: leftcapinset, bottom: bottominset, right: rightcapinset)
        let imagewithinset = image.resizableImage(withCapInsets: inset, resizingMode: .stretch)
        
        
        self.image = imagewithinset
    }
    func setimage(input: String) {
        
        guard let url = URL(string: input) else { return }
        self.kf.indicatorType = .none
    
        self.kf.setImage(with: url)
        
        
        
    }
    
}
