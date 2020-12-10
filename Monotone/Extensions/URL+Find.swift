//
//  Array+Find.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/19.
//

import Foundation

extension URL {
    
    func value(of name: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == name })?.value
    }
}
