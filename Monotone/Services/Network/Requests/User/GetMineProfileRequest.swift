//
//  GetMineProfileRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/22.
//

import UIKit
import ObjectMapper

class GetMineProfileRequest: BaseRequest{
    
    override var api: String?{
        get{
            return "/me"
        }
    }
        
    override func mapping(map: Map) {
        //
    }
}
