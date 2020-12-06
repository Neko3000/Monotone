//
//  MTNavigationController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

class MTNavigationController: BaseNavigationController {
    
    // MARK: - Controls
    private var logoBtn: UIButton!
    private var backBtn: UIButton!
    private var closeBtn: UIButton!
    
    private var logoBarButtonItem: UIBarButtonItem!
    private var backBarButtonItem: UIBarButtonItem!
    private var closeBarButtonItem: UIBarButtonItem!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        
        // configure.
        self.updateNavBarTransparent(transparent: false)
        self.updateNavBarHidden(hidden: false)

        // logoBtn.
        self.logoBtn = UIButton()
        self.logoBtn.setImage(UIImage(named: "unsplash-logo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.logoBtn.tintColor = ColorPalette.colorBlack
        self.logoBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
        }
        self.logoBarButtonItem = UIBarButtonItem(customView: self.logoBtn)
        
        // backBtn.
        self.backBtn = UIButton()
        self.backBtn.setImage(UIImage(named: "nav-btn-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backBtn.tintColor = ColorPalette.colorBlack
        self.backBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
        }
        self.backBarButtonItem = UIBarButtonItem(customView: self.backBtn)
        
        // closeBtn.
        self.closeBtn = UIButton()
        self.closeBtn.setImage(UIImage(named: "nav-btn-close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeBtn.tintColor = ColorPalette.colorBlack
        self.closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
        }
        self.closeBarButtonItem = UIBarButtonItem(customView: self.closeBtn)
    }
    
    override public func updateNavBarTransparent(transparent: Bool){
        
        if(transparent){
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.view.backgroundColor = .clear
            
            self.navigationBar.isTranslucent = true
        }
        else{
            self.navigationBar.barTintColor = ColorPalette.colorWhite
            self.navigationBar.tintColor = ColorPalette.colorBlack

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
    
    override public func updateNavItems(){
        
        if(self.viewControllers.count <= 1){
            self.topViewController!.navigationItem.leftBarButtonItems = [self.logoBarButtonItem]
            self.topViewController!.navigationItem.rightBarButtonItems = [self.closeBarButtonItem]
        }
        else{
            self.topViewController!.navigationItem.leftBarButtonItems = [self.backBarButtonItem]
            self.topViewController!.navigationItem.rightBarButtonItems = [self.logoBarButtonItem]
        }
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
