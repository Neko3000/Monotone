//
//  GetCollectionPhotosRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/20.
//

import UIKit
import ObjectMapper

class GetCollectionPhotosRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "collections/\(self.id ?? "")/photos"
        }
    }
    
    public var id: String?
    public var page: Int?
    public var perPage: Int?
    public var orientation: String?
    
    override func mapping(map: Map) {
        page    <- map["page"]
        perPage <- map["per_page"]
        orientation <- map["orientation"]
    }
}
