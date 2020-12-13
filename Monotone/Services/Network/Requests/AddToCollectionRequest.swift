//
//  AddToCollectionRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/13.
//

import UIKit
import ObjectMapper

class AddToCollectionRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "collections/\(self.collectionId ?? "")/add"
        }
    }
    
    public var collectionId: String?
    public var photoId: String?
    
    override func mapping(map: Map) {
        photoId  <- map["photo_id"]
    }
}
