//
//  BaseScrollView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/27.
//

import UIKit

class BaseScrollView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func buildSubviews(){
        
    }
    
    func buildLogic(){
        
    }
}
