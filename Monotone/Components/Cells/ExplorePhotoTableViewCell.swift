//
//  ExplorePhotoTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/25.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class ExplorePhotoTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public var photoType: BehaviorRelay<ExplorePhotoType?> = BehaviorRelay<ExplorePhotoType?>(value: nil)

    // MARK: - Controls
    private var photoContainerView: UIView!
    private var photoAImageView: UIImageView!
    private var photoBImageView: UIImageView!
    
    private var keywordContainerView: UIView!
    private var keywordABtn: UIButton!
    private var keywordBBtn: UIButton!
    private var keywordMoreBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews(){
        
        //
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        // PhotoContainerView.
        self.photoContainerView = UIView()
        self.contentView.addSubview(self.photoContainerView)
        self.photoContainerView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self.contentView)
            make.height.equalTo(154.0)
        }
        
        // PhotoAImageView
        self.photoAImageView = UIImageView()
        self.photoAImageView.contentMode = .scaleAspectFill
        self.photoAImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoContainerView.addSubview(self.photoAImageView)
        self.photoAImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.photoContainerView)
            make.right.equalTo(self.photoContainerView).multipliedBy(2.0/3).offset(-3.0)
            make.bottom.equalTo(self.photoContainerView)
        }
        
        // PhotoBImageView
        self.photoBImageView = UIImageView()
        self.photoBImageView.contentMode = .scaleAspectFill
        self.photoBImageView.backgroundColor = ColorPalette.colorGrayLighter
        self.photoContainerView.addSubview(self.photoBImageView)
        self.photoBImageView.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.photoContainerView)
            make.left.equalTo(self.photoContainerView).multipliedBy(2.0/3).offset(3.0)
            make.bottom.equalTo(self.photoContainerView)
        }
        
        // KeywordContainerView.
        self.keywordContainerView = UIView()
        self.contentView.addSubview(self.keywordContainerView)
        self.keywordContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoContainerView.snp.bottom).offset(26.0)
            make.right.left.equalTo(self.contentView)
            make.height.equalTo(40.0)
            make.bottom.equalTo(self.contentView).offset(-26.0)
        }
        
        // KeywordABtn.
        self.keywordABtn = UIButton()
        self.keywordABtn.backgroundColor = ColorPalette.colorGrayLight
        self.keywordContainerView.addSubview(self.keywordABtn)
        self.keywordABtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.keywordContainerView)
            make.centerX.equalTo(self.keywordContainerView.snp.right).multipliedBy(1.0/4)
            make.width.equalTo(self.keywordContainerView).multipliedBy(1.0/4)
            make.bottom.equalTo(self.keywordContainerView)
        }
        
        // KeywordBBtn.
        self.keywordBBtn = UIButton()
        self.keywordBBtn.backgroundColor = ColorPalette.colorGrayLight
        self.keywordContainerView.addSubview(self.keywordBBtn)
        self.keywordBBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.keywordContainerView)
            make.centerX.equalTo(self.keywordContainerView.snp.right).multipliedBy(2.0/4)
            make.width.equalTo(self.keywordContainerView).multipliedBy(1.0/4)
            make.bottom.equalTo(self.keywordContainerView)
        }
        
        // KeywordMoreBtn.
        self.keywordMoreBtn = UIButton()
        self.keywordMoreBtn.backgroundColor = ColorPalette.colorBlack
        self.contentView.addSubview(self.keywordMoreBtn)
        self.keywordMoreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.keywordContainerView)
            make.centerX.equalTo(self.keywordContainerView.snp.right).multipliedBy(3.0/4)
            make.width.equalTo(self.keywordContainerView).multipliedBy(1.0/4)
            make.bottom.equalTo(self.keywordContainerView)
        }
    }

    private func buildLogic(){
        
        // Bindings.
        // MadeWithUnsplashItem.
        self.photoType
            .unwrap()
            .subscribe(onNext:{ [weak self] (photoType) in
                guard let self = self else { return }
                
                photoType.rawValue.previewPhotos?
                    .prefix(self.photoContainerView.subviews.count)
                    .enumerated()
                    .forEach({ (index, element) in
                        let imageView = self.subviews[index] as! UIImageView
                        
                        imageView.kf.setImage(with: URL(string: element.urls?.small ?? ""),
                                              placeholder: UIImage(blurHash: element.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                              options: [.transition(.fade(0.7)), .originalCache(.default)])
                    })
                
                photoType.rawValue.keywords?
                    .prefix(self.keywordContainerView.subviews.count)
                    .enumerated()
                    .forEach({ (index, element) in
                        let btn = self.keywordContainerView.subviews[index] as! UIButton
                        
                        // setTitle
                    })

            })
            .disposed(by: self.disposeBag)
            
    }
}
