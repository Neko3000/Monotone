//
//  StatisticizeUserRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import Foundation
import ObjectMapper

class StatisticizeUserRequest: BaseRequest {

    override var api: String?{
        get{
            return "users/\(self.username ?? "")/statistics"
        }
    }
    
    public var username: String?
    public var resolution: String?
    public var quantity: Int?
    
    override func mapping(map: Map) {
        resolution    <- map["resolution"]
        quantity      <- map["quantity"]
    }
}
