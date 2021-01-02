//
//  PageTitleView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import RxSwift
import RxRelay

class PageTitleView: BaseView {
    
    // MARK: - Public
    public var title: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    public var subtitle: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    
    private var horizontalLineLong: UIView!
    private var horizontalLineShort: UIView!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.titleLabel.text = "Building West"
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
        }
        
        // SubtitleLabel.
        self.subtitleLabel = UILabel()
        self.subtitleLabel.textColor = ColorPalette.colorGrayLight
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subtitleLabel.text = "Published on November 28, 2018."
        self.addSubview(self.subtitleLabel)
        self.subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5.0)
            make.right.equalTo(self)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            make.bottom.equalTo(self)
        }
        
        // HorizontalLineShort.
        self.horizontalLineShort = UIView()
        self.horizontalLineShort.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalLineShort)
        self.horizontalLineShort.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalTo(self)
            make.width.equalTo(8.0)
            make.height.equalTo(1.0)
        }
        
        // HorizontalLineLong.
        self.horizontalLineLong = UIView()
        self.horizontalLineLong.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalLineLong)
        self.horizontalLineLong.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.left.equalTo(self.titleLabel.snp.right).offset(28.0)
            make.right.equalTo(self.horizontalLineShort.snp.left).offset(-8.0)
            make.height.equalTo(1.0)
            make.width.greaterThanOrEqualTo(10.0)
        }
        
    }

    override func buildLogic() {
        super.buildLogic()
        
        // Bindings
        self.title.bind(to: self.titleLabel.rx.text).disposed(by: self.disposeBag)
        self.subtitle.bind(to: self.subtitleLabel.rx.text).disposed(by: self.disposeBag)
    }
}
