//
//  PhotoShareURLView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import Foundation

import RxSwift
import RxRelay

class PhotoShareURLView: BaseView{
    
    // MARK: - Public
    public var url: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    // MARK: - Controls
    private var urlLabel: UILabel!
    private var copyBtn: UIButton!
    
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
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = ColorPalette.colorBlack.cgColor
        
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        // URLLabel.
        self.urlLabel = UILabel()
        self.urlLabel.font = UIFont.systemFont(ofSize: 12)
        self.urlLabel.textColor = ColorPalette.colorGrayLight
        self.urlLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.urlLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.addSubview(self.urlLabel)
        self.urlLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(11.0)
            make.centerY.equalTo(self)
        }
        
        // CopyBtn.
        self.copyBtn = UIButton()
        self.copyBtn.backgroundColor = ColorPalette.colorBlack
        self.copyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.copyBtn.setTitleColor(ColorPalette.colorWhite, for: .normal)
        self.copyBtn.setTitle(NSLocalizedString("uns_share_copy_btn_title", comment: "Copy Link"), for: .normal)
        self.copyBtn.layer.cornerRadius = 2.0
        self.copyBtn.layer.masksToBounds = true
        self.copyBtn.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        self.copyBtn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.copyBtn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
        // URL.
        self.url
            .bind(to: self.urlLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        // CopyBtn.
        self.copyBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                
                UIPasteboard.general.string = self.url.value
                MessageCenter.shared.showMessage(title: NSLocalizedString("uns_share_copy_message_title", comment: "Copied"),
                                                 body: NSLocalizedString("uns_share_copy_message_description", comment: "The URL of this photo has been copied to clipboard successfully."),
                                                 theme: .success)
            })
            .disposed(by: self.disposeBag)
    }
}
