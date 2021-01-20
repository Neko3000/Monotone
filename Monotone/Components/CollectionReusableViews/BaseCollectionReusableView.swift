//
//  BaseCollectionReusableView.swift
//  Monotone
//
//  Created by Xueliang Chen on 1/20/21.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func buildSubviews(){
        // Implemented by subclass.
    }
    
    func buildLogic(){
        // Implemented by subclass.
    }
}
