//
//  RemoveFromCollectionRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/14.
//

import UIKit
import ObjectMapper

class RemoveFromCollectionRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "collections/\(self.collectionId ?? "")/remove"
        }
    }
    
    public var collectionId: String?
    public var photoId: String?
    
    override func mapping(map: Map) {
        photoId  <- map["photo_id"]
    }
}
