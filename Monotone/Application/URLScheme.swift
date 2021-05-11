//
//  URLScheme.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/9.
//

import Foundation

class URLScheme{
    // For XCode 12.5 or later, the scheme for ASWebAuthenticationSession should be written like this instead of "monotone://".
    // Otherwise, a error rises - "A scheme should not include special characters such as..."
    public static let main = "monotone"
}
