//
//  StoreBannerTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/10.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class StoreBannerTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public var storeItem: BehaviorRelay<StoreItem?> = BehaviorRelay<StoreItem?>(value: nil)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var coverImageView: UIImageView!
    private var stateLabel: SpaceLabel!
    private var priceLabel: UILabel!
    
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
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        // CoverImageView.
        self.coverImageView = UIImageView()
        self.coverImageView.contentMode = .scaleAspectFill
        self.coverImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.coverImageView)
        self.coverImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(14.0)
            make.top.equalTo(self.contentView).offset(12.0)
            make.right.bottom.equalTo(self.contentView)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.numberOfLines = 0
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView).offset(29.0)
            make.bottom.equalTo(self.contentView).offset(-12.0)
            make.right.equalTo(self.contentView).multipliedBy(3.0/5)
        })
        
        // StateLabel.
        self.stateLabel = SpaceLabel()
        self.stateLabel.textColor = ColorPalette.colorWhite
        self.stateLabel.font = UIFont.systemFont(ofSize: 12)
        self.stateLabel.backgroundColor = ColorPalette.colorGrayLight
        self.stateLabel.paddingInsets = UIEdgeInsets(top: 6.0, left: 8.0, bottom: 6.0, right: 8.0)
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(6.0)
        })
        
        // PriceLabel.
        self.priceLabel = UILabel()
        self.priceLabel.textColor = UIColor.white
        self.priceLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView).offset(-17.0)
            make.bottom.equalTo(self.contentView).offset(-21.0)
        })
    }

    private func buildLogic(){
        
        // Bindings.
        // MadeWithUnsplashItem.
        self.storeItem
            .unwrap()
            .subscribe(onNext:{ [weak self] (item) in
                guard let self = self else { return }
                
                self.coverImageView.image = item.coverImage
                self.titleLabel.text = item.title
                self.stateLabel.text = item.state
                self.priceLabel.text = String(format: "$%@", item.price?.format(digit:2) ?? "999.0") 

            })
            .disposed(by: self.disposeBag)
            
    }
}
