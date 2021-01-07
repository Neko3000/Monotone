//
//  MadeWithUnsplashTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/8.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class MadeWithUnsplashTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public var madeItem: BehaviorRelay<MadeItem?> = BehaviorRelay<MadeItem?>(value: nil)

    // MARK: - Controls
    private var coverImageView: UIImageView!
    private var enterImageView: UIImageView!
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
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        // CoverImageView.
        self.coverImageView = UIImageView()
        self.coverImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.coverImageView)
        self.coverImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(20.0)
            make.right.equalTo(self.contentView).offset(-24.0)
            make.bottom.equalTo(self.contentView).offset(-54.0)
            make.left.equalTo(self.contentView)
        }
        
        // EnterImageView.
        self.enterImageView = UIImageView()
        self.enterImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.enterImageView)
        self.enterImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView)
            make.width.height.equalTo(39.0)
        }
        
        // UsernameLabel.
        self.usernameLabel = UILabel()
        self.usernameLabel.font = UIFont.systemFont(ofSize: 12)
        self.usernameLabel.textColor = ColorPalette.colorWhite
        self.usernameLabel.backgroundColor = ColorPalette.colorBlack
        self.contentView.addSubview(self.usernameLabel)
        self.usernameLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-31.0)
            make.width.equalTo(148.0)
            make.height.equalTo(39.0)
        })
    }

    private func buildLogic(){
        
        // Bindings.
        // MadeItem.
        self.madeItem
            .unwrap()
            .subscribe(onNext:{ [weak self] (madeItem) in
                guard let self = self else { return }
                
                self.coverImageView.image = madeItem.coverImage
                self.usernameLabel.text = madeItem.username
                
            })
            .disposed(by: self.disposeBag)
            
    }
}
