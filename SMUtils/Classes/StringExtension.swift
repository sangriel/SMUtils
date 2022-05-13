//
//  StringExtension.swift
//  SMUtils
//
//  Created by sangmin han on 2022/05/12.
//

import Foundation

public extension String{
   
    func convertCurrency( money : NSNumber, style : NumberFormatter.Style ) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        
        return numberFormatter.string( from: money )!
    }
    func encodeemoji() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    func decodeemoji() -> String? {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    private func createRandomStr(length: Int) -> String {
        let str = (0 ..< length).map{ _ in self.randomElement()! }
        return String(str)
    }
    
    func randomContentGenerator() -> String {
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let size =  Int.random(in: 30...100) // 0~10 사이의 Int 값
        let iv = str.createRandomStr(length: size)
        
        return iv
    }
    
    
    
}

