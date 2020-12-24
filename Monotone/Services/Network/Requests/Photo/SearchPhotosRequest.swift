//
//  SearchPhotosRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation
import ObjectMapper

class SearchPhotosRequest: BaseRequest {
        
    override var api: String?{
        get{
            return "search/photos"
        }
    }
    
    public var query: String?
    public var page: Int?
    public var perPage: Int?
    public var orderBy: String?
    public var collections: [String]?
    public var contentFilter: String?
    public var color: String?
    public var oritentation: String?
    
    override func mapping(map: Map) {
        query           <- map["query"]
        page            <- map["page"]
        perPage         <- map["per_page"]
        orderBy         <- map["order_by"]
        collections     <- map["query"]
        contentFilter   <- map["content_filter"]
        color           <- map["color"]
        oritentation    <- map["oritentation"]
    }
}
