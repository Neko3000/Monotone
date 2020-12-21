//
//  SideMenuProfileView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import Foundation

import RxSwift
import RxRelay

class SideMenuProfileView: BaseView{
    
    // MARK: Public
    
    // MARK: Controls
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var editBtn: UIButton!
    private var signOutBtn: UIButton!
    
    private var collectionBtn: UIButton!
    private var likeBtn: UIButton!
    
    private var collectionsView: SideMenuProfileCollectionView!
    
//    private var enterBtn: UIButton!
        
    // MARK: Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func buildSubviews() {
        super.buildSubviews()
        
        // avatarImageView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.backgroundColor = UIColor.blue
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.width.height.equalTo(83.0)
        }
        
        // usernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorBlack
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.usernameLabel.text = "Joan Notinghham"
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(20.0)
            make.right.equalTo(self)
            make.top.equalTo(self).offset(10.0)
        }
        
        // editBtn.
        self.editBtn = UIButton()
        self.editBtn.backgroundColor = ColorPalette.colorBlack
        self.editBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.editBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.editBtn.setTitle("Edit Profile", for: .normal)
        self.addSubview(self.editBtn)
        self.editBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(10.0)
        }
        
        // signOutBtn.
        self.signOutBtn = UIButton()
        self.signOutBtn.backgroundColor = ColorPalette.colorBlack
        self.signOutBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.signOutBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.signOutBtn.setTitle("Edit Profile", for: .normal)
        self.addSubview(self.signOutBtn)
        self.signOutBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.editBtn.snp.right).offset(15.0)
            make.centerY.equalTo(self.editBtn)
        }
        
        // collectionBtn.
        self.collectionBtn = UIButton()
        self.collectionBtn.setTitleColor(ColorPalette.colorBlack, for: .normal)
        self.collectionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.collectionBtn.setTitle("21 Collections", for: .normal)
        self.addSubview(self.collectionBtn)
        self.collectionBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView)
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(22.0)
        }
        
        // likeBtn.
        self.likeBtn = UIButton()
        self.likeBtn.setTitleColor(ColorPalette.colorBlack, for: .normal)
        self.likeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.likeBtn.setTitle("220 Liked", for: .normal)
        self.addSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.collectionBtn.snp.right).offset(20.0)
            make.centerY.equalTo(self.collectionBtn)
        }
        
        // collectionsView.
        self.collectionsView = SideMenuProfileCollectionView()
        self.addSubview(self.collectionsView)
        self.collectionsView.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView)
            make.top.equalTo(self.collectionBtn.snp.bottom).offset(22.0)
            make.bottom.equalTo(self)
            make.height.equalTo(219.0)
            make.width.equalTo(237.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.

    }
}
