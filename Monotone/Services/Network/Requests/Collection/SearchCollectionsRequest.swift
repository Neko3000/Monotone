//
//  SearchCollectionsRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/27.
//

import UIKit
import ObjectMapper

class SearchCollectionsRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "search/collections"
        }
    }
    
    public var query: String?
    public var page: Int?
    public var perPage: Int?
    
    override func mapping(map: Map) {
        query   <- map["query"]
        page    <- map["page"]
        perPage <- map["per_page"]
    }
}
