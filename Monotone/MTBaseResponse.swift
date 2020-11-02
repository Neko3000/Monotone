//
//  MTBaseResponse.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation

protocol MTBaseResponsePtotocol {
    init(json:[String:Any])
}

class MTBaseResponse : MTBaseResponsePtotocol{
    required init(json: [String : Any]) {
        
    }
}


