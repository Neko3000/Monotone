//
//  Array+Find.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/19.
//

import Foundation

extension Array{
    public func find<T>(by type: T.Type) -> T?{
        
        if let element = self.first(where: { (element) -> Bool in
            let elementTypeStr = String(describing: element.self).components(separatedBy: ".").last!
            let typeStr = String(describing: type).components(separatedBy: ".").last!
            
            return elementTypeStr == typeStr
        }){
            return element as? T
        }
        else{
            print("Could not find element of type: '\(String(describing: type))'")
            return nil
        }
    }
}
