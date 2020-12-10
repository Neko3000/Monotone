//
//  AuthArguments.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/9.
//

import Foundation

class AuthArguments{
    public static let redirectUri: String = "monotone://unsplash"
    public static let responseType: String = "code"
    public static let scope: String = "read_user+write_user"
    public static let grandType: String = "authorization_code"
}
