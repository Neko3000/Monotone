//
//  PhotoDetailsOpeartionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import UIKit

import SnapKit

class PhotoDetailsOpeartionView: BaseView {
    
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    
    private var stackView: UIStackView!
    private var downloadBtn: UIButton!
    private var shareBtn: UIButton!
    private var infoBtn: UIButton!
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func buildSubviews() {
        
        // avatarImageView
        self.avatarImageView = UIImageView()
        self.avatarImageView.backgroundColor = UIColor.red
        self.avatarImageView.layer.cornerRadius = 14.0
        self.avatarImageView.layer.masksToBounds = true
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(17.0)
            make.width.height.equalTo(28.0)
        }
        
        // usernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.text = "Terry Crews"
        self.usernameLabel.textColor = UIColor.white
        self.usernameLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(10.0)
            make.centerY.equalTo(self.avatarImageView)
        }
        
        // stackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .horizontal
        self.stackView.semanticContentAttribute = .forceRightToLeft
        self.stackView.spacing = 26.0
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(30.0)
        }
        
        // downloadBtn.
        self.downloadBtn = UIButton()
        self.downloadBtn.setImage(UIImage(named: "bar-btn-download"), for: .normal)
        self.downloadBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        self.stackView.addArrangedSubview(self.downloadBtn!)
        
        // shareBtn.
        self.shareBtn = UIButton()
        self.shareBtn.setImage(UIImage(named: "bar-btn-share"), for: .normal)
        self.shareBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        self.stackView.addArrangedSubview(self.shareBtn!)
        
        // infoBtn.
        self.infoBtn = UIButton()
        self.infoBtn.setImage(UIImage(named: "bar-btn-info"), for: .normal)
        self.infoBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        self.stackView.addArrangedSubview(self.infoBtn!)
    }

}
