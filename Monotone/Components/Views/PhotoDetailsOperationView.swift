//
//  PhotoDetailsOperationView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import UIKit

import SnapKit

class PhotoDetailsOperationView: BaseView {
        
    // MARK: - Controls
    public var downloadBtn: UIButton!
    public var shareBtn: UIButton!
    public var infoBtn: UIButton!
    
    private var stackView: UIStackView!
    
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
        
        // StackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .horizontal
        self.stackView.semanticContentAttribute = .forceRightToLeft
        self.stackView.spacing = 26.0
        self.stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(30.0)
        }
        
        // DownloadBtn.
        self.downloadBtn = UIButton()
        self.downloadBtn.setImage(UIImage(named: "bar-btn-download"), for: .normal)
        self.downloadBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        self.stackView.addArrangedSubview(self.downloadBtn!)
        
        // ShareBtn.
        self.shareBtn = UIButton()
        self.shareBtn.setImage(UIImage(named: "bar-btn-share"), for: .normal)
        self.shareBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        self.stackView.addArrangedSubview(self.shareBtn!)
        
        // InfoBtn.
        self.infoBtn = UIButton()
        self.infoBtn.setImage(UIImage(named: "bar-btn-info"), for: .normal)
        self.infoBtn.snp.makeConstraints { (make) in
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        self.stackView.addArrangedSubview(self.infoBtn!)
    }
    
    override func buildLogic() {
        super.buildLogic()
    }
}
