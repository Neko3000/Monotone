//
//  SideMenuProfileView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import Foundation

import anim

import RxSwift
import RxRelay

// MARK: - SideMenuProfileView
class SideMenuProfileView: BaseView{
    
    // MARK: - Public
    var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    var collections: BehaviorRelay<[Collection]?> = BehaviorRelay<[Collection]?>(value: nil)
    var photos: BehaviorRelay<[Photo]?> = BehaviorRelay<[Photo]?>(value: nil)
    
    // MARK: - Controls
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var editBtn: UIButton!
    private var signOutBtn: UIButton!
    
    private var collectionBtn: UIButton!
    private var likeBtn: UIButton!
    
    private var containerView: UIView!
    private var collectionView: SideMenuProfileCollectionView!
    private var likeView: SideMenuProfileLikeView!
        
//    private var enterBtn: UIButton!
        
    // MARK: - Private
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
        
        // AvatarImageView.
        self.avatarImageView = UIImageView()
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.backgroundColor = UIColor.blue
        self.avatarImageView.layer.cornerRadius = 42.0
        self.avatarImageView.layer.masksToBounds = true
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.width.height.equalTo(83.0)
        }
        
        // UsernameLabel.
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
        
        // EditBtn.
        self.editBtn = UIButton()
        self.editBtn.backgroundColor = ColorPalette.colorBlack
        self.editBtn.contentEdgeInsets = UIEdgeInsets(top: 6.0, left: 10.0, bottom: 6.0, right: 10.0)
        self.editBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.editBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.editBtn.setTitle("Edit Profile", for: .normal)
        self.addSubview(self.editBtn)
        self.editBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(10.0)
        }
        
        // SignOutBtn.
        self.signOutBtn = UIButton()
        self.signOutBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.signOutBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.signOutBtn.setImage(UIImage(named: "profile-sign-out"), for: .normal)
        self.addSubview(self.signOutBtn)
        self.signOutBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.editBtn.snp.right).offset(15.0)
            make.centerY.equalTo(self.editBtn)
        }
        
        self.containerView = UIView()
        self.containerView.layer.masksToBounds = true
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView)
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(64.0)
            make.bottom.equalTo(self)
            make.height.equalTo(219.0)
            make.width.equalTo(237.0)
        }
        
        // CollectionView.
        self.collectionView = SideMenuProfileCollectionView()
        self.containerView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.containerView)
            make.top.equalTo(self.containerView)
            make.left.equalTo(self.containerView)
        }
        
        // LikeView.
        self.likeView = SideMenuProfileLikeView()
        self.containerView.addSubview(self.likeView)
        self.likeView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.containerView)
            make.top.equalTo(self.containerView)
            make.left.equalTo(self.containerView.snp.right)
        }
        
        // CollectionBtn.
        self.collectionBtn = UIButton()
        self.collectionBtn.isSelected = true
        self.collectionBtn.setTitle("21 Collections", for: .normal)
        self.collectionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.collectionBtn.imageEdgeInsets = UIEdgeInsets(top: -2.0, left: 0, bottom: 2.0, right: 0)
        self.collectionBtn.setTitleColor(ColorPalette.colorGrayLight, for: .normal)
        self.collectionBtn.setTitleColor(ColorPalette.colorBlack, for: .selected)
        self.collectionBtn.setImage(UIImage(named: "profile-collection"), for: .normal)
        self.collectionBtn.setImage(UIImage(named: "profile-collection-selected"), for: .selected)
        self.addSubview(self.collectionBtn)
        self.collectionBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView)
            make.bottom.equalTo(self.containerView.snp.top).offset(-22.0)
        }
        
        // LikeBtn.
        self.likeBtn = UIButton()
        self.likeBtn.isSelected = false
        self.likeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.likeBtn.imageEdgeInsets = UIEdgeInsets(top: -2.0, left: 0, bottom: 2.0, right: 0)
        self.likeBtn.setTitleColor(ColorPalette.colorGrayLight, for: .normal)
        self.likeBtn.setTitleColor(ColorPalette.colorBlack, for: .selected)
        self.likeBtn.setImage(UIImage(named: "profile-like"), for: .normal)
        self.likeBtn.setImage(UIImage(named: "profile-like-selected"), for: .selected)
        self.addSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.collectionBtn.snp.right).offset(20.0)
            make.centerY.equalTo(self.collectionBtn)
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
                
                self.avatarImageView.kf.setImage(with: URL(string: user.profileImage?.large ?? ""),
                                                 options: [.transition(.fade(0.7)), .originalCache(.default)])
                
                self.collectionBtn.setTitle(String(format: NSLocalizedString("unsplash_side_menu_collection_count_suffix", comment: "%d Collections"), user.totalCollections ?? 0), for: .normal)
                self.likeBtn.setTitle(String(format: NSLocalizedString("unsplash_side_menu_like_count_suffix", comment: "%d Liked"), user.totalLikes ?? 0), for: .normal)
                
            })
            .disposed(by: self.disposeBag)
        
        // Collections.
        self.collections
            .unwrap()
            .flatMap({ (collections) -> Observable<Collection?> in
                return Observable.just(collections.first)
            })
            .bind(to: self.collectionView.collection)
            .disposed(by: self.disposeBag)
        
        // Photos.
        self.photos
            .unwrap()
            .flatMap({ (photos) -> Observable<Photo?> in
                return Observable.just(photos.first)
            })
            .bind(to: self.likeView.photo)
            .disposed(by: self.disposeBag)

        // Tap.
        self.collectionBtn.rx.tap
            .ignoreWhen({ self.collectionBtn.isSelected })
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                self.collectionBtn.isSelected = true
                self.likeBtn.isSelected = false
                
                self.animation(animationState: .showCollectionView)
            }
            .disposed(by: self.disposeBag)
        
        self.likeBtn.rx.tap
            .ignoreWhen({ self.likeBtn.isSelected })
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                self.likeBtn.isSelected = true
                self.collectionBtn.isSelected = false
                
                self.animation(animationState: .showLikeView)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewAnimatable
extension SideMenuProfileView: ViewAnimatable{
    
    // MARK: - Enums
    enum AnimationState {
        case showCollectionView
        case showLikeView
    }
    
    // MARK: - Animation
    // Animation for collectionView & likeView
    func animation(animationState: AnimationState) {
        switch animationState {
        case .showCollectionView:
            
            anim(constraintParent: self) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {

                    self.collectionView.snp.remakeConstraints({ (make) in
                        make.width.height.equalTo(self.containerView)
                        make.top.equalTo(self.containerView)
                        make.left.equalTo(self.containerView)
                    })
                    
                    self.likeView.snp.remakeConstraints { (make) in
                        make.width.height.equalTo(self.containerView)
                        make.top.equalTo(self.containerView)
                        make.left.equalTo(self.containerView.snp.right)
                    }
                }
            }
            
            break
            
        case .showLikeView:
            
            anim(constraintParent: self) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    
                    self.collectionView.snp.remakeConstraints({ (make) in
                        make.width.height.equalTo(self.containerView)
                        make.top.equalTo(self.containerView)
                        make.right.equalTo(self.containerView.snp.left)
                    })
                    
                    self.likeView.snp.remakeConstraints { (make) in
                        make.width.height.equalTo(self.containerView)
                        make.top.equalTo(self.containerView)
                        make.left.equalTo(self.containerView)
                    }
                }
            }
            
            break
        }
    }
}
