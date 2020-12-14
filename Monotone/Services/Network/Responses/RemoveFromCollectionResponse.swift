//
//  RemoveFromCollectionResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/14.
//

import Foundation
import ObjectMapper

class RemoveFromCollectionResponse: BaseResponse{
    public var photo: Photo?
    
    override func mapping(map: Map) {
        photo = Photo(map: map)
    }
}
