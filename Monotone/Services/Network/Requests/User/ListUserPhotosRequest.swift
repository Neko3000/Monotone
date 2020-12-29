//
//  ListUserLikedPhotosRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/24.
//

import Foundation
import ObjectMapper

class ListUserPhotosRequest: BaseRequest {

    override var api: String?{
        get{
            return "users/\(self.username ?? "")/photos"
        }
    }
    
    public var username: String?
    public var page: Int?
    public var perPage: Int?
    public var orderBy: String?
    public var stats: Bool?
    public var resolution: String?
    public var quantity: Int?
    public var orientation: String?
    
    override func mapping(map: Map) {
        username        <- map["username"]
        page            <- map["page"]
        perPage         <- map["per_page"]
        orderBy         <- map["order_by"]
        stats           <- map["stats"]
        resolution      <- map["resolution"]
        quantity        <- map["quantity"]
        orientation     <- map["orientation"]
    }
}
