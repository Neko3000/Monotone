//
//  AuthError.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/10.
//

import Foundation

class AuthError: LocalizedError{
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
