//
//  Decimal+Format.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/16.
//

import Foundation

extension Decimal {
    
    // https://stackoverflow.com/questions/46933209/how-to-convert-decimal-to-string-with-two-digits-after-separator
    // Ladislav, answered Oct 25 '17 at 13:16
    public func format(digit:Int = 0) -> String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = digit
        formatter.maximumFractionDigits = digit
        return formatter.string(from: self as NSDecimalNumber)
    }
}
