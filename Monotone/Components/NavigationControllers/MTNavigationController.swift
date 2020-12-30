//
//  MTNavigationController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

import RxSwift
import RxRelay

class MTNavigationController: BaseNavigationController {
    
    // MARK: - Public
    public var backBtnDidTap: PublishRelay<Void> = PublishRelay<Void>()
    public var closeBtnDidTap: PublishRelay<Void> = PublishRelay<Void>()
    
    // MARK: - Controls
    private var logoBtn: UIButton!
    private var backBtn: UIButton!
    private var closeBtn: UIButton!
    
    private var logoBarButtonItem: UIBarButtonItem!
    private var backBarButtonItem: UIBarButtonItem!
    private var closeBarButtonItem: UIBarButtonItem!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        
        // Configure.
        self.updateNavBarTransparent(transparent: false)
        self.updateNavBarHidden(hidden: false)

        // LogoBtn.
        self.logoBtn = UIButton()
        self.logoBtn.setImage(UIImage(named: "unsplash-logo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.logoBtn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        self.logoBtn.tintColor = ColorPalette.colorBlack
        self.logoBtn.isEnabled = false
        self.logoBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30.0)
        }
        self.logoBarButtonItem = UIBarButtonItem(customView: self.logoBtn)
        
        // BackBtn.
        self.backBtn = UIButton()
        self.backBtn.setImage(UIImage(named: "nav-btn-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backBtn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        self.backBtn.tintColor = ColorPalette.colorBlack
        self.backBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30.0)
        }
        self.backBarButtonItem = UIBarButtonItem(customView: self.backBtn)
        
        // CloseBtn.
        self.closeBtn = UIButton()
        self.closeBtn.setImage(UIImage(named: "nav-btn-close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeBtn.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0 ,right: 5.0)
        self.closeBtn.tintColor = ColorPalette.colorBlack
        self.closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30.0)
        }
        self.closeBarButtonItem = UIBarButtonItem(customView: self.closeBtn)
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Buttons
        self.backBtn.rx.tap
            .bind(to: self.backBtnDidTap)
            .disposed(by: self.disposeBag)
        
        self.closeBtn.rx.tap
            .bind(to: self.closeBtnDidTap)
            .disposed(by: self.disposeBag)
    }
    
    override public func updateNavBarTransparent(transparent: Bool){
                
        if(transparent){
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.view.backgroundColor = .clear
            self.navigationBar.shadowImage = UIImage()
            
            self.navigationBar.isTranslucent = true
        }
        else{
            self.navigationBar.barTintColor = ColorPalette.colorWhite
            self.navigationBar.tintColor = ColorPalette.colorBlack
            self.navigationBar.shadowImage = UIImage()

            self.navigationBar.isTranslucent = false
        }
    }
    
    override public func updateNavBarHidden(hidden: Bool){
        
        if(hidden){
            self.setNavigationBarHidden(true, animated: false)
        }
        else{
            self.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override public func updateNavItems(color: UIColor? = nil,
                                        leftItems: [UIBarButtonItem]? = nil,
                                        rightItems: [UIBarButtonItem]? = nil){
        
        // LeftBarButtonItems
        if let leftItems = leftItems{
            self.topViewController!.navigationItem.leftBarButtonItems = leftItems
        }
        else{
            self.topViewController!.navigationItem.leftBarButtonItems = self.viewControllers.count <= 1 ? [self.logoBarButtonItem] : [self.backBarButtonItem]
        }
        
        // RightBarButtonItems
        if let rightItems = rightItems{
            self.topViewController!.navigationItem.rightBarButtonItems = rightItems
        }
        else{
            self.topViewController!.navigationItem.rightBarButtonItems = self.viewControllers.count <= 1 ? [self.closeBarButtonItem] : [self.logoBarButtonItem]
        }
        
        // Color
        self.topViewController!.navigationItem.leftBarButtonItems?.forEach({ (item) in
            item.customView?.tintColor = color ?? ColorPalette.colorBlack
        })
        self.topViewController!.navigationItem.rightBarButtonItems?.forEach({ (item) in
            item.customView?.tintColor = color ?? ColorPalette.colorBlack
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
