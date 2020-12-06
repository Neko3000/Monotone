//
//  PhotoShareUrlView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import Foundation

import RxSwift
import RxRelay

class PhotoShareUrlView: BaseView{
    
    // MARK: Public
    public var url: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    // MARK: Controls
    private var urlLabel: UILabel!
    private var copyBtn: UIButton!
    
    // MARK: Private
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
        
        // urlLabel.
        self.urlLabel = UILabel()
        self.urlLabel.font = UIFont.systemFont(ofSize: 12)
        self.urlLabel.textColor = ColorPalette.colorGrayLight
        self.urlLabel.text = "https://unsplash.com/photos/3wKKpxlZr1Q"
        self.urlLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.urlLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(self.urlLabel)
        self.urlLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10.0)
            make.centerY.equalTo(self)
        }
        
        // copyBtn.
        self.copyBtn = UIButton()
        self.copyBtn.backgroundColor = ColorPalette.colorBlack
        self.copyBtn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.copyBtn.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.copyBtn.setTitle("Copy Link", for: .normal)
        self.addSubview(self.copyBtn)
        self.copyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10.0)
            make.centerY.equalTo(self)
            make.left.equalTo(self.urlLabel.snp.right).offset(12.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        self.url.bind(to: self.urlLabel.rx.text).disposed(by: self.disposeBag)
    }
}
