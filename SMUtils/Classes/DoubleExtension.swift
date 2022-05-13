//
//  DoubleExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation


public extension Double {
    var clean : String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        
        formatter.maximumFractionDigits = 1
        
        //maximum digits in Double after dot (maximum precision)
        return formatter.string(from: number) ?? ""
    }
    
}


