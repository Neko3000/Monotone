//
//  TableViewSection.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit
import RxDataSources

struct TableViewSection{
    public var key: String?
    public var title: String?
    public var description: String?
    public var items: [Any]
}

extension TableViewSection: SectionModelType{
    typealias Item = Any
    
    init(original: TableViewSection, items: [Item]) {
        self = original
        self.items = items
    }
}
