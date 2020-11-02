//
//  MTHTTPMethod.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation

import Alamofire

enum MTHTTPMethod{
    case connect
    case delete
    case get
    case head
    case options
    case patch
    case put
    case trace

    var rawValue : HTTPMethod{
        
        switch self {
        case .connect:
            return HTTPMethod.connect
        case .delete:
            return HTTPMethod.delete
        case .get:
            return HTTPMethod.get
        case .head:
            return HTTPMethod.head
        case .options:
            return HTTPMethod.options
        case .patch:
            return HTTPMethod.patch
        case .put:
            return HTTPMethod.put
        case .trace:
            return HTTPMethod.trace
        default:
            return HTTPMethod.get
        }
    }
}
