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
        
        // photoImageView
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.backgroundColor = UIColor.blue
        self.photoImageView.layer.masksToBounds = true
        self.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self)
        }
        
        
        // avatarImageView
        self.avatarImageView = UIImageView()
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.backgroundColor = UIColor.blue
        self.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoImageView.snp.bottom).offset(11.0)
            make.left.equalTo(self).offset(5.0)
            make.bottom.equalTo(self)
            make.width.height.equalTo(24.0)
        }
        
        // usernameLabel
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorBlack
        self.usernameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.usernameLabel.text = "David"
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(10.0)
            make.top.equalTo(self.avatarImageView)
        }
        
        // descriptionLabel
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.text = "1 photos · Curated by Joan"
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.usernameLabel.snp.bottom)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        self.photo
            .unwrap()
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                self.photoImageView.kf.setImage(with: URL(string: photo.urls?.small ?? ""),
                                      placeholder: UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                      options: [.transition(.fade(0.7)), .originalCache(.default)])
                
                let editor = photo.sponsorship?.sponsor ?? photo.user

                self.usernameLabel.text = editor?.username ?? ""
                self.descriptionLabel.text = String(format: NSLocalizedString("unsplash_side_menu_like_description",
                                                                              comment: "%d Photos · %@"),
                                                    editor?.totalPhotos ?? 0,
                                                    photo.exif?.model ?? "")
                
                
                self.avatarImageView.kf.setImage(with: URL(string: editor?.profileImage?.medium ?? ""),
                                            options: [.transition(.fade(0.7)), .originalCache(.default)])
                
            })
            .disposed(by: self.disposeBag)
    }
}
