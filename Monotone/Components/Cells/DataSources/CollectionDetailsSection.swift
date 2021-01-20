//
//  CollectionDetailsSection.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/20.
//

import UIKit
import RxDataSources

struct CollectionDetailsSection{
    public var header: Collection?
    public var items: [Photo]
}

extension CollectionDetailsSection: SectionModelType{
    typealias Item = Photo
    
    init(original: CollectionDetailsSection, items: [Item]) {
        self = original
        self.items = items
    }
}
