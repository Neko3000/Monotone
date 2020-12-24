//
//  LikePhotoResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/15.
//

import Foundation
import ObjectMapper

class LikePhotoResponse: BaseResponse{
    public var photo: Photo?
    
    override func mapping(map: Map) {
        photo <- map["photo"]
    }
}
