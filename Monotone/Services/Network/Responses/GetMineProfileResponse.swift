//
//  GetMineProfileResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/22.
//

import Foundation
import ObjectMapper

class GetMineProfileResponse: BaseResponse{
    public var user: User?
    
    override func mapping(map: Map) {
        user = User(map: map)
    }
}
