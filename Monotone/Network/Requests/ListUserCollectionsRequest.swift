//
//  ListUserCollectionsRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/7.
//

import Foundation
import ObjectMapper

class ListUserCollectionsRequest: BaseRequest {

    override var api: String?{
        get{
            return "users/\(self.username ?? "")/collections"
        }
    }
    
    public var username: String?
    public var page: Int?
    public var perPage: Int?
    
    override func mapping(map: Map) {
        username        <- map["username"]
        page            <- map["page"]
        perPage         <- map["per_page"]
    }
}
