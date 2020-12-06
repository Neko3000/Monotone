//
//  PhotoInfoStatisticsView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import RxSwift
import RxRelay

class PhotoShareSMView: BaseView {
    
    // MARK: Public
    
    // MARK: Controls
    private var pinterestBtn: FloatBlockButton!
    private var instagramBtn: FloatBlockButton!
    private var facebookBtn: FloatBlockButton!
    private var emailBtn: FloatBlockButton!
    private var twitterBtn: FloatBlockButton!
    
    // MARK: Private

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func buildSubviews() {
        self.pinterestBtn = FloatBlockButton()
        self.pinterestBtn.setTitle("pinterest", for: .normal)
        self.pinterestBtn.setImage(UIImage(named: "unsplash-logo"), for: .normal)
        self.addSubview(self.pinterestBtn)
        self.pinterestBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80.0)
        }
        
        self.instagramBtn = FloatBlockButton()
        self.instagramBtn.setTitle("instagram", for: .normal)
        self.instagramBtn.setImage(UIImage(named: "unsplash-logo"), for: .normal)
        self.addSubview(self.instagramBtn)
        self.instagramBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(1.0/5)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80.0)
        }
        
        self.facebookBtn = FloatBlockButton()
        self.facebookBtn.setTitle("facebook", for: .normal)
        self.facebookBtn.setImage(UIImage(named: "unsplash-logo"), for: .normal)
        self.addSubview(self.facebookBtn)
        self.facebookBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(2.0/5)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80.0)
        }
        
        self.emailBtn = FloatBlockButton()
        self.emailBtn.setTitle("email", for: .normal)
        self.emailBtn.setImage(UIImage(named: "unsplash-logo"), for: .normal)
        self.addSubview(self.emailBtn)
        self.emailBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(3.0/5)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80.0)
        }
        
        self.twitterBtn = FloatBlockButton()
        self.twitterBtn.setTitle("twitter", for: .normal)
        self.twitterBtn.setImage(UIImage(named: "unsplash-logo"), for: .normal)
        self.addSubview(self.twitterBtn)
        self.twitterBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(4.0/5)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80.0)
        }
    }
    
    override func buildLogic() {
        
        // Bindings
        
    }
}
