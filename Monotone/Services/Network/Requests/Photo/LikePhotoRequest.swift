//
//  LikePhotoRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/15.
//

import UIKit
import ObjectMapper

class LikePhotoRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "photos/\(self.id ?? "")/like"
        }
    }
    
    public var id: String?
    
    override func mapping(map: Map) {
        id  <- map["id"]
    }
}
