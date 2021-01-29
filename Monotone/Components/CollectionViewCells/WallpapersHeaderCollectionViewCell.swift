//
//  WallpapersHeaderCollectionViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/16.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class WallpapersHeaderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public
    public var wallpaperSize: BehaviorRelay<WallpaperSize?> = BehaviorRelay<WallpaperSize?>(value: nil)

    // MARK: - Controls
    private var coverImageView: UIImageView!
    private var titleLabel: UILabel!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews(){
        
        self.backgroundColor = ColorPalette.colorGrayLighter
        
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        // ImageView.
        self.coverImageView = UIImageView()
        self.coverImageView.contentMode = .scaleAspectFill
        self.coverImageView.backgroundColor = ColorPalette.colorGrayLight
        self.contentView.addSubview(self.coverImageView)
        self.coverImageView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.contentView)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel.textColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.center.equalTo(self.contentView)
            make.left.greaterThanOrEqualTo(self.contentView).offset(10.0)
            make.right.lessThanOrEqualTo(self.contentView).offset(-10.0)
        })
    }

    private func buildLogic(){
        
        // Bindings.
        // WallpaperSize.
        self.wallpaperSize
            .unwrap()
            .subscribe(onNext:{ [weak self] (wallpaperSize) in
                guard let self = self else { return }
                
                self.coverImageView.image = wallpaperSize.rawValue.image
                self.titleLabel.text = wallpaperSize.rawValue.title
                
            })
            .disposed(by: self.disposeBag)
            
    }
}
