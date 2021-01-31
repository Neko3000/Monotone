//
//  MyProfileHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class MyProfileHeaderView: BaseView {
    
    // MARK: - Public
    public var profileContent: BehaviorRelay<ProfileContent?> = BehaviorRelay<ProfileContent?>(value: nil)
    public var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    public var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)

    // MARK: - Controls
    private var avatarImageView: UIImageView!
    private var statisticsView: UserStatisticsView!
    
    private var currentSelectionLabel: UILabel!
    
    private var stackView: UIStackView!
    private var photoBtn: UIButton!
    private var collectionBtn: UIButton!
    private var likeBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // 
        self.backgroundColor = ColorPalette.colorWhite
        
        // AvatarImageView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.layer.cornerRadius = 6.0
        self.avatarImageView.layer.masksToBounds = true
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50.0)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self.snp.right).multipliedBy(4.0/7)
            make.bottom.equalTo(self).offset(-48.0)
        }
        
        // StatisticsView.
        self.statisticsView = UserStatisticsView()
        self.addSubview(self.statisticsView)
        self.statisticsView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.avatarImageView)
            make.left.equalTo(self.avatarImageView.snp.right)
            make.right.equalTo(self)
        }
        
        // CurrentSelectionLabel.
        self.currentSelectionLabel = UILabel()
        self.currentSelectionLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.currentSelectionLabel.textColor = ColorPalette.colorBlack
        self.currentSelectionLabel.text = "12 Collections"
        self.addSubview(self.currentSelectionLabel)
        self.currentSelectionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(18.0)
        }
        
        // StackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .horizontal
        self.stackView.semanticContentAttribute = .forceRightToLeft
        self.stackView.spacing = 15.0
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.bottom.equalTo(self.currentSelectionLabel)
        }
        
        // LikeBtn.
        self.likeBtn = UIButton()
        self.likeBtn.setImage(UIImage(named: "profile-like"), for: .normal)
        self.likeBtn.setImage(UIImage(named: "profile-like-selected"), for: .selected)
        self.stackView.addArrangedSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
        }
        
        // CollectionBtn.
        self.collectionBtn = UIButton()
        self.collectionBtn.setImage(UIImage(named: "profile-collection"), for: .normal)
        self.collectionBtn.setImage(UIImage(named: "profile-collection-selected"), for: .selected)
        self.stackView.addArrangedSubview(self.collectionBtn)
        self.collectionBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
        }
        
        // PhotoBtn.
        self.photoBtn = UIButton()
        self.photoBtn.setImage(UIImage(named: "profile-photo"), for: .normal)
        self.photoBtn.setImage(UIImage(named: "profile-photo-selected"), for: .selected)
        self.stackView.addArrangedSubview(self.photoBtn)
        self.photoBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // User.
        self.user
            .unwrap()
            .subscribe(onNext:{ [weak self] (user) in
                guard let self = self else { return }
                
                self.avatarImageView.setUserAvatar(user: user, size: .large)
            })
            .disposed(by: self.disposeBag)
        
        // Statistics.
        self.statistics
            .bind(to: self.statisticsView.statistics)
            .disposed(by: self.disposeBag)
        
        // PhotoBtn.
        self.photoBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                
                self.currentSelectionLabel.text = String(format: "%d photos", self.user.value?.totalPhotos ?? 0)
                
                self.deselectAllBtns()
                self.photoBtn.isSelected = true
                self.profileContent.accept(.photos)
            })
            .disposed(by: self.disposeBag)
        
        // CollectionBtn.
        self.collectionBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                
                self.currentSelectionLabel.text = String(format: "%d collections", self.user.value?.totalCollections ?? 0)
                
                self.deselectAllBtns()
                self.collectionBtn.isSelected = true
                self.profileContent.accept(.collections)
            })
            .disposed(by: self.disposeBag)
        
        // LikeBtn.
        self.likeBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                
                self.currentSelectionLabel.text = String(format: "%d likes", self.user.value?.totalLikes ?? 0)
                
                self.deselectAllBtns()
                self.likeBtn.isSelected = true
                self.profileContent.accept(.likedPhotos)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func deselectAllBtns(){
        
        self.stackView.subviews.forEach { (view) in
            
            if let btn = view as? UIButton{
                btn.isSelected = false
            }
        }
    }
}
