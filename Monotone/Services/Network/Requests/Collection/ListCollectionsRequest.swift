//
//  ListCollectionsRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/11.
//

import UIKit
import ObjectMapper

class ListCollectionsRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "collections"
        }
    }
    
    public var page: Int?
    public var perPage: Int?
    
    override func mapping(map: Map) {
        page    <- map["page"]
        perPage <- map["per_page"]
    }
}
