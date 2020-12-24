//
//  GetTopicPhotosRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/22.
//

import UIKit
import ObjectMapper

class GetTopicPhotosRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "topics/\(self.idOrSlug ?? "")/photos"
        }
    }
    
    public var idOrSlug: String?
    public var page: Int?
    public var perPage: Int?
    public var oritentation: String?
    public var orderBy: String?
    
    override func mapping(map: Map) {
        page            <- map["page"]
        perPage         <- map["per_page"]
        oritentation    <- map["oritentation"]
        orderBy         <- map["order_by"]
    }
}
