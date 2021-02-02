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

import anim

class MyProfileHeaderView: BaseView {
    
    // MARK: - Public
    public var profileContent: BehaviorRelay<ProfileContent?> = BehaviorRelay<ProfileContent?>(value: nil)
    public var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    public var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)
    
    public var animationState: BehaviorRelay<AnimationState> = BehaviorRelay<AnimationState>(value: .showDetails)

    // MARK: - Controls
    private var avatarImageView: UIImageView!
    private var statisticsView: UserStatisticsView!
    private var usernameLabel: UILabel!
    
    private var currentSelectionLabel: UILabel!
    
    private var stackView: UIStackView!
    private var photoBtn: UIButton!
    private var collectionBtn: UIButton!
    private var likeBtn: UIButton!
    
    private var horizontalLineLong: UIView!
    private var horizontalLineShort: UIView!
    
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
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorGrayLighter
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 72)
        self.usernameLabel.text = "nil"
        self.insertSubview(self.usernameLabel, belowSubview: self.avatarImageView)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.avatarImageView.snp.top).offset(-20.0)
            make.left.equalTo(self.avatarImageView)
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
        self.likeBtn.setImage(UIImage(named: "profile-details-like"), for: .normal)
        self.likeBtn.setImage(UIImage(named: "profile-details-like-selected"), for: .selected)
        self.stackView.addArrangedSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
        }
        
        // CollectionBtn.
        self.collectionBtn = UIButton()
        self.collectionBtn.setImage(UIImage(named: "profile-details-collection"), for: .normal)
        self.collectionBtn.setImage(UIImage(named: "profile-details-collection-selected"), for: .selected)
        self.stackView.addArrangedSubview(self.collectionBtn)
        self.collectionBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
        }
        
        // PhotoBtn.
        self.photoBtn = UIButton()
        self.photoBtn.setImage(UIImage(named: "profile-details-photo"), for: .normal)
        self.photoBtn.setImage(UIImage(named: "profile-details-photo-selected"), for: .selected)
        self.stackView.addArrangedSubview(self.photoBtn)
        self.photoBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(30.0)
        }
        
        // HorizontalLineShort.
        self.horizontalLineShort = UIView()
        self.horizontalLineShort.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalLineShort)
        self.horizontalLineShort.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView)
            make.right.equalTo(self).offset(-20.0)
            make.width.equalTo(8.0)
            make.height.equalTo(1.0)
        }
        
        // HorizontalLineLong.
        self.horizontalLineLong = UIView()
        self.horizontalLineLong.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalLineLong)
        self.horizontalLineLong.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView)
            make.left.equalTo(self.avatarImageView.snp.right).offset(20.0)
            make.right.equalTo(self.horizontalLineShort.snp.left).offset(-8.0)
            make.height.equalTo(1.0)
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
                
                self.usernameLabel.text = user.username
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
                self.profileContent.accept(.photos)
            })
            .disposed(by: self.disposeBag)
        
        // CollectionBtn.
        self.collectionBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                self.profileContent.accept(.collections)
            })
            .disposed(by: self.disposeBag)
        
        // LikeBtn.
        self.likeBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                self.profileContent.accept(.likedPhotos)
            })
            .disposed(by: self.disposeBag)
        
        // ProfileContent & User.
        Observable.combineLatest(self.profileContent, self.user)
            .subscribe(onNext: { [weak self] (profileContent, user) in
                guard let self = self else { return }
                
                self.deselectAllBtns()
                if(profileContent == .photos){
                    self.photoBtn.isSelected = true
                    self.currentSelectionLabel.text = String(format: NSLocalizedString("uns_side_menu_photo_count_suffix",comment: "%d Photos"),
                                                             self.user.value?.totalPhotos ?? 0)
                }
                else if(profileContent == .collections){
                    self.collectionBtn.isSelected = true
                    self.currentSelectionLabel.text = String(format: NSLocalizedString("uns_side_menu_collection_count_suffix",comment: "%d Collections"),
                                                             self.user.value?.totalCollections ?? 0)
                }
                else if(profileContent == .likedPhotos){
                    self.likeBtn.isSelected = true
                    self.currentSelectionLabel.text = String(format: NSLocalizedString("uns_side_menu_like_count_suffix",comment: "%d Likes"),
                                                             self.user.value?.totalLikes ?? 0)
                }
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

// MARK: - ViewAnimatable
extension MyProfileHeaderView: ViewAnimatable{
    
    // MARK: - Enums
    enum AnimationState {
        case showDetails
        case showSummary
    }
    
    // MARK: - BuildAnimation
    @objc func buildAnimation() {
        
        // AnimationState.
        self.animationState
            .skipWhile({ $0 == .showDetails })
            .distinctUntilChanged()
            .subscribe(onNext:{ [weak self] (animationState) in
                guard let self = self else { return }

                self.animation(animationState: animationState)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Animation
    func animation(animationState: AnimationState) {
        switch animationState {
        case .showDetails:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.statisticsView.alpha = 1.0
                    self.horizontalLineLong.alpha = 1.0
                    self.horizontalLineShort.alpha = 1.0
                    
                    self.avatarImageView.layer.cornerRadius = 6.0
                }
            }
            
            anim(constraintParent: self) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {

                    self.avatarImageView.snp.remakeConstraints { (make) in
                        make.top.equalTo(self).offset(50.0)
                        make.left.equalTo(self).offset(18.0)
                        make.right.equalTo(self.snp.right).multipliedBy(4.0/7)
                        make.bottom.equalTo(self).offset(-48.0)
                    }
                    
                    self.usernameLabel.snp.remakeConstraints { (make) in
                        make.centerY.equalTo(self.avatarImageView.snp.top).offset(-20.0)
                        make.left.equalTo(self.avatarImageView)
                    }
                }
            }
            
            break
            
        case .showSummary:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.statisticsView.alpha = 0
                    self.horizontalLineLong.alpha = 0
                    self.horizontalLineShort.alpha = 0
                    
                    self.avatarImageView.layer.cornerRadius = 60.0
                }
            }
            
            anim(constraintParent: self) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    
                    self.avatarImageView.snp.remakeConstraints { (make) in
                        make.centerX.centerY.equalTo(self)
                        make.width.height.equalTo(120.0)
                    }
                    
                    self.usernameLabel.snp.remakeConstraints { (make) in
                        make.left.right.equalTo(self)
                        make.centerY.equalTo(self.snp.bottom).multipliedBy(1.0/4)
                    }
                }
            }
            
            break
        }
    }
}

// MARK: - ViewWithAnimator
extension MyProfileHeaderView: ViewWithAnimator{
    
    @objc func buildAnimator() {
        
        // AnimatorTrigger.
        AnimatorTrigger.float(views: [
            self.usernameLabel,
            self.avatarImageView,
            self.currentSelectionLabel
        ],
        direction: .toTop)
        
        AnimatorTrigger.float(views: [
            self.photoBtn,
            self.collectionBtn,
            self.likeBtn
        ],
        direction: .toLeft)
    }
}
