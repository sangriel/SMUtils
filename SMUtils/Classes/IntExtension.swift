//
//  IntExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation


public extension Int {
    var currency : String {
        return "".convertCurrency(money: NSNumber(value: self) , style: .decimal)
    }
}


