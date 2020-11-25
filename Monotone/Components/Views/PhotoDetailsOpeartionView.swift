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
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(17.0)
            make.width.height.equalTo(28.0)
        }
        
        // usernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.text = "Terry Crews"
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView!.snp.right).offset(10.0)
        }
        
        // stackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .horizontal
        self.stackView.semanticContentAttribute = .forceRightToLeft
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
