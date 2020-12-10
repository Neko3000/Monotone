//
//  NetworkError.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation

class NetworkError: LocalizedError{
    let errorStrs: [String]
    
    init(errorStrs: [String]) {
        self.errorStrs = errorStrs
    }
    
    var errorDescription: String? {
        get{
            return self.errorStrs.joined(separator: "\n")
        }
    }
}
