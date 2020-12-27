//
//  String+Split.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/8.
//

import Foundation

extension String {
    
    // https://stackoverflow.com/questions/32465121/splitting-a-string-in-swift-using-multiple-delimiters
    // by meomeomeo, answered May 23 '19 at 6:17.
    func components(separatedBy separators: [String]) -> [String]{
        var result = [self]
        for separator in separators {
            result = result
                .map { $0.components(separatedBy: separator)}
                .flatMap { $0 }
        }
        return result
    }
}
