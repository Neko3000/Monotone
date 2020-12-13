//
//  ListTopicsRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation
import ObjectMapper

class ListTopicsRequeset: BaseRequest{
    
    override var api: String?{
        get{
            return "topics"
        }
    }
    
    public var ids: String?
    public var page: Int?
    public var perPage: Int?
    public var orderBy: Int?
    
    override func mapping(map: Map) {
        ids     <- map["ids"]
        page    <- map["page"]
        perPage <- map["per_page"]
        orderBy <- map["order_by"]
    }
}
