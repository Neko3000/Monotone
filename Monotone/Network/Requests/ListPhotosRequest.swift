//
//  ListPhotosRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation
import ObjectMapper

class ListPhotosRequest: BaseRequest {

    override var api: String?{
        get{
            return "photos/"
        }
    }
    
    public var page: Int?
    public var perPage: Int?
    public var orderBy: String?
    
    override func mapping(map: Map) {
        page            <- map["page"]
        perPage         <- map["per_page"]
        orderBy         <- map["order_by"]
    }
}
