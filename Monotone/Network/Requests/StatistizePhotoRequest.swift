//
//  StatisticizePhotoRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/2.
//

import Foundation
import ObjectMapper

class StatisticizePhotoRequest: BaseRequest {

    override var api: String?{
        get{
            return "photos/\(self.id ?? "")/statistics"
        }
    }
    
    public var id: String?
    public var resolution: String?
    public var quantity: Int?
    
    override func mapping(map: Map) {
        id            <- map["id"]
        resolution    <- map["resolution"]
        quantity      <- map["quantity"]
    }
}
