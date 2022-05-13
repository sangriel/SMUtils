//
//  FloatExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation


public extension Float {
    
    var clean : String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter.string(from: number) ?? ""
    }
    
}
