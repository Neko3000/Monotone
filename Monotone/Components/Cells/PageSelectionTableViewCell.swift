//
//  PageSelectionTableViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class PageSelectionTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public var item: BehaviorRelay<(key:Any,value:String)?> = BehaviorRelay<(key:Any,value:String)?>(value: nil)

    // MARK: - Controls
    public var titleLabel: UILabel!
    public var horizontalLineLong: UIView!
    public var horizontalLineShort: UIView!
    
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
            
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.textColor = ColorPalette.colorGrayLight
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
        })
        
        // HorizontalLongView.
        self.horizontalLineLong = UIView()
        self.horizontalLineLong.backgroundColor = ColorPalette.colorBlack
        self.horizontalLineLong.isHidden = true
        self.contentView.addSubview(self.horizontalLineLong)
        self.horizontalLineLong.snp.makeConstraints({ (make) in
            make.top.right.equalTo(self.contentView)
            make.width.equalTo(16.0)
            make.height.equalTo(1.0)
        })
        
        // HorizontalShortView.
        self.horizontalLineShort = UIView()
        self.horizontalLineShort.backgroundColor = ColorPalette.colorBlack
        self.horizontalLineShort.isHidden = true
        self.contentView.addSubview(self.horizontalLineShort)
        self.horizontalLineShort.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.horizontalLineLong.snp.left).offset(-4.0)
            make.width.equalTo(5.0)
            make.height.equalTo(1.0)
        })
    }

    private func buildLogic(){
        
        // Bindings.
        // Item.
        self.item
            .unwrap()
            .flatMap { (item) -> Observable<String> in
                return Observable.just(item.value)
            }
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
            
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected){
            self.titleLabel.textColor = ColorPalette.colorBlack
            self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            self.horizontalLineLong.isHidden = false
            self.horizontalLineShort.isHidden = false
        }
        else{
            self.titleLabel.textColor = ColorPalette.colorGrayLight
            self.titleLabel.font = UIFont.systemFont(ofSize: 14)
            self.horizontalLineLong.isHidden = true
            self.horizontalLineShort.isHidden = true
        }
    }
}
