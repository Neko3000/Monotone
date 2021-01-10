//
//  StoreTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/10.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class StoreTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public var storeItem: BehaviorRelay<StoreItem?> = BehaviorRelay<StoreItem?>(value: nil)
    
    public var alignToRight: Bool = false{
        didSet{
            self.resetLayout()
        }
    }

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var coverImageView: UIImageView!
    private var priceLabel: UILabel!
    private var usernameLabel: UILabel!
    
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
        
        // CoverImageView.
        self.coverImageView = UIImageView()
        self.coverImageView.contentMode = .scaleAspectFill
        self.coverImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.coverImageView)
        self.coverImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-76.0)
            make.width.equalTo(self.contentView).multipliedBy(3.0/5)
        }
        
        // PriceLabel.
        self.priceLabel = UILabel()
        self.priceLabel.textColor = ColorPalette.colorBlack
        self.priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(self.coverImageView)
            make.bottom.equalTo(self.contentView).offset(-50.0)
        })
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView).offset(15.0)
            make.bottom.equalTo(self.contentView).offset(-50.0)
            make.right.equalTo(self.priceLabel.snp.left).offset(-15.0)
        })
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.textColor = ColorPalette.colorGrayNormal
        self.usernameLabel.font = UIFont.systemFont(ofSize: 8)
        self.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.equalTo(self.titleLabel)
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
                self.priceLabel.text = "$\(item.price ?? 999.0)"
                self.usernameLabel.text = "by \(item.username ?? "")"
                
            })
            .disposed(by: self.disposeBag)
            
    }
    
    private func resetLayout(){
        
        if(self.alignToRight){
            
            self.coverImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView)
                make.right.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView).offset(-76.0)
                make.width.equalTo(self.contentView).multipliedBy(3.0/5)
            }
            
            self.priceLabel.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.coverImageView).offset(-15.0)
                make.bottom.equalTo(self.contentView).offset(-50.0)
            })
            
            self.titleLabel.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.coverImageView)
                make.bottom.equalTo(self.contentView).offset(-50.0)
                make.right.equalTo(self.priceLabel.snp.left).offset(-15.0)
            })
            
        }
        else{
            
            self.coverImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView)
                make.left.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView).offset(-76.0)
                make.width.equalTo(self.contentView).multipliedBy(3.0/5)
            }
            
            self.priceLabel.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.coverImageView)
                make.bottom.equalTo(self.contentView).offset(-50.0)
            })
            
            self.titleLabel.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.contentView).offset(15.0)
                make.bottom.equalTo(self.contentView).offset(-50.0)
                make.right.equalTo(self.priceLabel.snp.left).offset(-15.0)
            })
            
        }
        
        self.layoutIfNeeded()
    }
}
