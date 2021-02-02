//
//  PhotoInfoStatisticsView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import RxSwift
import RxRelay

class PhotoShareSNSView: BaseView {
    
    // MARK: - Public
    //
    
    // MARK: - Controls
    private var pinterestBtn: FloatBlockButton!
    private var instagramBtn: FloatBlockButton!
    private var facebookBtn: FloatBlockButton!
    private var emailBtn: FloatBlockButton!
    private var twitterBtn: FloatBlockButton!
    private var stackView: UIStackView!
    
    // MARK: - Private

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // StackView.
        self.stackView = UIStackView()
        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        self.stackView.distribution = .equalSpacing
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self)
        }
        
        // PinterestBtn.
        self.pinterestBtn = FloatBlockButton()
        self.pinterestBtn.setTitle("pinterest", for: .normal)
        self.pinterestBtn.setImage(UIImage(named: "social-pinterest"), for: .normal)
        self.stackView.addArrangedSubview(self.pinterestBtn)
        self.pinterestBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(80.0)
        }
        
        // InstagramBtn.
        self.instagramBtn = FloatBlockButton()
        self.instagramBtn.setTitle("instagram", for: .normal)
        self.instagramBtn.setImage(UIImage(named: "social-instagram"), for: .normal)
        self.stackView.addArrangedSubview(self.instagramBtn)
        self.instagramBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(80.0)
        }
        
        // FacebookBtn.
        self.facebookBtn = FloatBlockButton()
        self.facebookBtn.setTitle("facebook", for: .normal)
        self.facebookBtn.setImage(UIImage(named: "social-facebook"), for: .normal)
        self.stackView.addArrangedSubview(self.facebookBtn)
        self.facebookBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(80.0)
        }
        
        // EmailBtn.
        self.emailBtn = FloatBlockButton()
        self.emailBtn.setTitle("email", for: .normal)
        self.emailBtn.setImage(UIImage(named: "social-email"), for: .normal)
        self.stackView.addArrangedSubview(self.emailBtn)
        self.emailBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(80.0)
        }
        
        // TwitterBtn.
        self.twitterBtn = FloatBlockButton()
        self.twitterBtn.setTitle("twitter", for: .normal)
        self.twitterBtn.setImage(UIImage(named: "social-twitter"), for: .normal)
        self.stackView.addArrangedSubview(self.twitterBtn)
        self.twitterBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(80.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        //
    }
}

// MARK: - ViewWithAnimator
extension PhotoShareSNSView: ViewWithAnimator{
    
    @objc func buildAnimator() {
        
        // AnimatorTrigger.
        AnimatorTrigger.float(views: [
            self.pinterestBtn,
            self.instagramBtn,
            self.facebookBtn,
            self.emailBtn,
            self.twitterBtn
        ],
        direction: .toLeft)
    }
}
