//
//  TableViewSection.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit
import RxDataSources

struct TableViewSection{
    public var header: String
    public var items: [AnyObject]
}

extension TableViewSection: SectionModelType{
    typealias Item = AnyObject
    
    init(original: TableViewSection, items: [Item]) {
        self = original
        self.items = items
    }
}
