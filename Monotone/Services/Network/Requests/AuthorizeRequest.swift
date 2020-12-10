//
//  AuthorizeRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/8.
//

import UIKit
import ObjectMapper

class AuthorizeRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "authorize"
        }
    }
    
    public var clientId: String?
    public var redirectUri: String?
    public var responseType: String?
    public var scope: String?
    
    override func mapping(map: Map) {
        clientId        <- map["client_id"]
        redirectUri     <- map["redirect_uri"]
        responseType    <- map["response_type"]
        scope           <- map["scope"]
    }
}
