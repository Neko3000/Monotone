//
//  CreateCollectionResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/11.
//

import Foundation
import ObjectMapper

class CreateCollectionResponse: BaseResponse{
    public var collection: Collection?
    
    override func mapping(map: Map) {
        collection = Collection(map: map)
    }
}
