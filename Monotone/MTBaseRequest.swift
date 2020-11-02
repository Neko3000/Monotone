//
//  MTBaseRequest.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/1.
//

import Foundation

protocol MJBaseRequestProtocol {
    var api : String?{ get }
    var json : [String : Any]?{ get }
}

class MTBaseRequest : MJBaseRequestProtocol{
    var api: String?{ get{ return "" } }
    var json: [String : Any]?{ get{ return nil }}
}
