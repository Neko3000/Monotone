//
//  CapsuleView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/17.
//

import UIKit

class CapsuleView: BaseView {
    
    // MARK: - Enums
    enum BackgroundStyle{
        case normal
        case blur
    }
    
    // MARK: - Public
    public var backgroundStyle: BackgroundStyle = .normal{
        didSet{
            self.updateBackgroundStyle()
        }
    }
    public var views: [UIView] = []{
        didSet{
            self.stackView.subviews.forEach { self.stackView.removeArrangedSubview($0) }
            views.forEach { self.stackView.addArrangedSubview($0) }
        }
    }
    
    // MARK: - Controls
    private var stackView: UIStackView!
    
    // MARK: - Private
    private var blurBackgroundView: UIVisualEffectView!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    convenience init(views:[UIView]) {
//        self.init()
//
//        views.forEach { [weak self](view) in
//            guard let self = self else { return }
//
//            self.stackView.addArrangedSubview(view)
//        }
//    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Life Cycle
    override func buildSubviews(){
        super.buildSubviews()
        
        // blurBackgroundView.
        let blurEffect = UIBlurEffect(style: .light)
        self.blurBackgroundView = UIVisualEffectView(effect: blurEffect)
        self.blurBackgroundView.isUserInteractionEnabled = false
        
        // stackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .horizontal
        self.stackView.spacing = 11.0
        self.stackView.layoutMargins = UIEdgeInsets(top: 11.0, left: 11.0, bottom: 11.0, right: 11.0)
        self.stackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self)
        }
    }
    
    override func buildLogic(){
        super.buildLogic()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.layer.masksToBounds = true
    }
    
    private func updateBackgroundStyle(){
        switch self.backgroundStyle {
        case .normal:
            
            self.blurBackgroundView.removeFromSuperview()
            self.backgroundColor = UIColor.clear
            break
        case .blur:
            
            self.insertSubview(self.blurBackgroundView, belowSubview: self.stackView!)
            self.blurBackgroundView.snp.makeConstraints { (make) in
                make.left.top.right.bottom.equalTo(self)
            }
            self.backgroundColor = UIColor.clear
            break
        }
    }
}
