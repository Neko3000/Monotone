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
    public static let scope: String = "public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections"
    public static let grandType: String = "authorization_code"
}
