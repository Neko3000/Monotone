//
//  CollectionDetailsHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit

import SnapKit
import Kingfisher
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class CollectionDetailsHeaderView: BaseView {
    
    // MARK: - Public
    public let collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var photoCountLabel: UILabel!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        //
        self.backgroundColor = ColorPalette.colorWhite
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.text = "nil"
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-18.0)
        }
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.text = "nil"
        self.descriptionLabel.numberOfLines = 0
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6.0)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-18.0)
        }
        
        // AvatarImageView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.avatarImageView.layer.cornerRadius = 20.0
        self.avatarImageView.layer.masksToBounds = true
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(20.0)
            make.left.equalTo(self).offset(18.0)
            make.width.height.equalTo(40.0)
        }
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorGrayHeavy
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.usernameLabel.text = "nil"
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.avatarImageView)
            make.left.equalTo(self.avatarImageView.snp.right).offset(15.0)
        }
        
        // PhotoCountLabel.
        self.photoCountLabel = UILabel()
        self.photoCountLabel.textColor = ColorPalette.colorBlack
        self.photoCountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.photoCountLabel.text = "0"
        self.addSubview(self.photoCountLabel)
        self.photoCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(19.0)
            make.left.equalTo(self.avatarImageView)
            make.bottom.equalTo(self).offset(-20.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // SegmentedControl.
        self.collection
            .unwrap()
            .subscribe(onNext: { [weak self] (collection) in
                guard let self = self else { return }
                
                self.titleLabel.text = collection.title
                self.descriptionLabel.text = collection.description
                
                let editor = collection.sponsorship?.sponsor ?? collection.user

                self.usernameLabel.text = editor?.username ?? ""
                self.avatarImageView.setUserAvatar(user: editor, size: .medium)
                self.photoCountLabel.text = String(format: NSLocalizedString("uns_collection_details_photo_count_suffix", comment: "%d photos"), collection.totalPhotos ?? 0)
            })
            .disposed(by: self.disposeBag)
    }
}
