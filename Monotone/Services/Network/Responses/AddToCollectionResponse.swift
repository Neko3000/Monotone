//
//  AddToCollectionResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/13.
//

import Foundation
import ObjectMapper

class AddToCollectionResponse: BaseResponse{
    public var photo: Photo?
    
    override func mapping(map: Map) {
        photo = Photo(map: map)
    }
}
