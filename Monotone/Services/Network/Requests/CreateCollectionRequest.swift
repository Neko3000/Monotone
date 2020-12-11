//
//  CreateCollectionRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/11.
//

import UIKit
import ObjectMapper

class CreateCollectionRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "/collections"
        }
    }
    
    public var title: String?
    public var description: String?
    public var isPrivate: Bool?
    
    override func mapping(map: Map) {
        title        <- map["title"]
        description  <- map["description"]
        isPrivate    <- map["private"]
    }
}
