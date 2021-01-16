//
//  StoreBannerView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class StoreBannerView: BaseView {
    
    // MARK: - Public
    public let storeItem: BehaviorRelay<StoreItem?> = BehaviorRelay<StoreItem?>(value: nil)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var coverImageView: UIImageView!
    private var stateLabel: SpaceLabel!
    private var priceLabel: UILabel!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        //
        
        // CoverImageView.
        self.coverImageView = UIImageView()
        self.coverImageView.contentMode = .scaleAspectFill
        self.coverImageView.layer.masksToBounds = true
        self.addSubview(self.coverImageView)
        self.coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(14.0)
            make.top.equalTo(self).offset(12.0)
            make.right.bottom.equalTo(self)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(29.0)
            make.bottom.equalTo(self).offset(-12.0)
            make.right.equalTo(self).multipliedBy(3.0/5)
        })
        
        // StateLabel.
        self.stateLabel = SpaceLabel()
        self.stateLabel.textColor = ColorPalette.colorWhite
        self.stateLabel.font = UIFont.systemFont(ofSize: 12)
        self.stateLabel.backgroundColor = ColorPalette.colorGrayLight
        self.stateLabel.paddingInsets = UIEdgeInsets(top: 6.0, left: 8.0, bottom: 6.0, right: 8.0)
        self.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(6.0)
        })
        
        // PriceLabel.
        self.priceLabel = UILabel()
        self.priceLabel.textColor = UIColor.white
        self.priceLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-17.0)
            make.bottom.equalTo(self).offset(-21.0)
        })
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // SegmentedControl
        self.storeItem
            .unwrap()
            .subscribe(onNext: { [weak self] (item) in
                guard let self = self else { return }
                
                self.coverImageView.image = item.coverImage
                self.titleLabel.text = item.title
                self.stateLabel.text = item.state
                self.priceLabel.text = String(format: "$%@", item.price?.format(digit:2) ?? "999.0") 
            })
            .disposed(by: self.disposeBag)
    }
}
