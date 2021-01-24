//
//  SideMenuProfileCollectionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import Foundation

import RxSwift
import RxRelay

class SideMenuProfileCollectionView: BaseView{
    
    // MARK: - Public
    var collection: BehaviorRelay<Collection?> = BehaviorRelay<Collection?>(value: nil)
    
    // MARK: - Controls
    private var photoContainerView: UIView!
    private var photoAImageView: UIImageView!
    private var photoBImageView: UIImageView!
    private var photoCImageView: UIImageView!
    
    private var titleLabel: UILabel!
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
        
        // PhotoContainerView
        self.photoContainerView = UIView()
        self.addSubview(self.photoContainerView)
        self.photoContainerView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self)
        }
        
        // PhotoAImageView
        self.photoAImageView = UIImageView()
        self.photoAImageView.contentMode = .scaleAspectFill
        self.photoAImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoContainerView.addSubview(self.photoAImageView)
        self.photoAImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.photoContainerView)
            make.bottom.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(-2.0)
            make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-2.0)
        }
        
        // PhotoBImageView
        self.photoBImageView = UIImageView()
        self.photoBImageView.contentMode = .scaleAspectFill
        self.photoBImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoContainerView.addSubview(self.photoBImageView)
        self.photoBImageView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self.photoContainerView)
            make.top.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(2.0)
            make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-2.0)
        }
        
        // PhotoCImageView
        self.photoCImageView = UIImageView()
        self.photoCImageView.contentMode = .scaleAspectFill
        self.photoCImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoContainerView.addSubview(self.photoCImageView)
        self.photoCImageView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self.photoContainerView)
            make.left.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(2.0)
        }
        
        // TitleLabel
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.titleLabel.text = "nil"
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self.photoContainerView.snp.bottom).offset(7.0)
        }
        
        // DescriptionLabel
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.text = "0 photos · Curated by nil"
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // Collection.
        self.collection
            .unwrap()
            .subscribe(onNext:{ [weak self] (collection) in
                guard let self = self else { return }
                
                let editor = collection.sponsorship?.sponsor ?? collection.user

                self.titleLabel.text = collection.title
                self.descriptionLabel.text = String(format: NSLocalizedString("uns_side_menu_collection_description",
                                                                              comment: "%d Photos · Curated by %@"),
                                                    collection.totalPhotos ?? 0,
                                                    editor?.username ?? "")
                
                collection.previewPhotos?
                    .prefix(self.photoContainerView.subviews.count)
                    .enumerated()
                    .forEach({ (index, element) in
                        let imageView = self.photoContainerView.subviews[index] as! UIImageView
                        
                        imageView.kf.setImage(with: URL(string: element.urls?.small ?? ""),
                                              placeholder: UIImage(blurHash: element.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                              options: [.transition(.fade(0.7)), .originalCache(.default)])
                    })
                
                
            })
            .disposed(by: self.disposeBag)
    }
}
