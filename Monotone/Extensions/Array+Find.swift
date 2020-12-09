//
//  Array+Find.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/19.
//

import Foundation

extension Array{
    
    
    /// Find the first element by a specific type in an array.
    /// - Parameter type: The specific type.
    /// - Returns: The first element whose type is same to the spcific type.
    public func find<T>(by type: T.Type) -> T?{
        
        if let element = self.first(where: { (element) -> Bool in
            // FIXME:
            // The code here is complicated cause the result of String(describing: element.self) always return
            // some values with their memory addresses, "<Monotone.AuthService: 0x280e34a00>" etc.
            // I can not figure the reason yet.
            
            let elementSplitedStrs = String(describing: element.self).components(separatedBy: ["."," ",":"])
            let typeStr = String(describing: type)
                        
            return elementSplitedStrs.contains(typeStr)
        }){
            return element as? T
        }
        else{
            print("Could not find element of type: '\(String(describing: type))'")
            return nil
        }
    }
}
