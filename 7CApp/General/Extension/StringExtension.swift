//
//  StringExtension.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Foundation



extension String {
    
    func roundedPrice() -> String {
        let stringArr  = self.components(separatedBy: " ").map { String($0)}
        guard stringArr.count == 2, let price = Double("\(stringArr.first ?? "")") else {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        let roundedPrice = formatter.string(from: NSNumber(value: price)) ?? ""
        let last = "\(stringArr.last ?? "")"
        return "\(roundedPrice) \(last)"
        
    }
}
