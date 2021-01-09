//
//  SideMenuProfileCollectionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import Foundation

import RxSwift
import RxRelay

class SideMenuProfileLikeView: BaseView{
    
    // MARK: - Public
    var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
    
    // MARK: - Controls
    private var photoImageView: UIImageView!
    
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var descriptionLabel: UILabel!

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
        
        // PhotoImageView
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoImageView.layer.masksToBounds = true
        self.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self)
        }
        
        // AvatarImageView
        self.avatarImageView = UIImageView()
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.avatarImageView.layer.cornerRadius = 12.0
        self.avatarImageView.layer.masksToBounds = true
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoImageView.snp.bottom).offset(10.0)
            make.left.equalTo(self).offset(5.0)
            make.bottom.equalTo(self).offset(-10.0)
            make.width.height.equalTo(24.0)
        }
        
        // UsernameLabel
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorBlack
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.usernameLabel.text = "nil"
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(10.0)
            make.top.equalTo(self.avatarImageView)
        }
        
        // DescriptionLabel
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.text = "0 Photos · nil"
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(10.0)
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(2.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // Photo.
        self.photo
            .unwrap()
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                self.photoImageView.kf.setImage(with: URL(string: photo.urls?.small ?? ""),
                                      placeholder: UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                      options: [.transition(.fade(0.7)), .originalCache(.default)])
                
                let editor = photo.sponsorship?.sponsor ?? photo.user

                self.usernameLabel.text = editor?.username ?? ""
                self.descriptionLabel.text = String(format: NSLocalizedString("uns_side_menu_like_description",
                                                                              comment: "%d Photos · %@"),
                                                    editor?.totalPhotos ?? 0,
                                                    photo.exif?.model ?? "")
                
                
                self.avatarImageView.kf.setImage(with: URL(string: editor?.profileImage?.medium ?? ""),
                                            options: [.transition(.fade(0.7)), .originalCache(.default)])
                
            })
            .disposed(by: self.disposeBag)
    }
}
