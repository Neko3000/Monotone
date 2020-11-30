//
//  MTNavigationController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

class MTNavigationController: BaseNavigationController {
    
    public var navbarHidden: Bool = false
    public var navbarTransparent: Bool = false
    
    private var logoBtn: UIButton!
    private var backBtn: UIButton!
    private var closeBtn: UIButton!
    
    private var logoBarButtonItem: UIBarButtonItem!
    private var backBarButtonItem: UIBarButtonItem!
    private var closeBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        self.configureNavigationBar(transparent: false)
        
        self.logoBtn = UIButton()
        self.logoBtn.setImage(UIImage(named: "unsplash-logo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.logoBtn.tintColor = ColorPalette.colorBlack
        self.logoBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
        }
        self.logoBarButtonItem = UIBarButtonItem(customView: self.logoBtn)
        
        self.backBtn = UIButton()
        self.backBtn.setImage(UIImage(named: "navi-btn-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backBtn.tintColor = ColorPalette.colorBlack
        self.backBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
        }
        self.backBarButtonItem = UIBarButtonItem(customView: self.backBtn)
        
        self.closeBtn = UIButton()
        self.closeBtn.setImage(UIImage(named: "navi-btn-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeBtn.tintColor = ColorPalette.colorBlack
        self.closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
        }
        self.closeBarButtonItem = UIBarButtonItem(customView: self.closeBtn)
    }
    
    public func configureNavigationBar(transparent: Bool){
        self.navigationBar.tintColor = ColorPalette.colorBlack
        
        if(transparent){
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.view.backgroundColor = .clear
            
            self.navigationBar.isTranslucent = true
        }
        else{
            self.navigationBar.barTintColor = ColorPalette.colorWhite

            self.navigationBar.isTranslucent = false
        }
        
//        // Background.
//        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.isTranslucent = true
//        self.view.backgroundColor = .clear
//
//        if(!transparent){
//            self.navigationBar.barTintColor = ColorPalette.colorWhite
//        }
//
//        // Left items.
//        self.navigationBar.backIndicatorImage = UIImage(named: "navi-btn-back")
        

    }
    
    public func updateNavgationItems(){
        
        if(self.viewControllers.count <= 1){
            self.topViewController!.navigationItem.leftBarButtonItems = [self.logoBarButtonItem]
            self.topViewController!.navigationItem.rightBarButtonItems = [self.closeBarButtonItem]
        }
        else{
            self.topViewController!.navigationItem.leftBarButtonItems = [self.backBarButtonItem]
            self.topViewController!.navigationItem.rightBarButtonItems = [self.logoBarButtonItem]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateNavgationItems()
    }
    
    private func configureNavigationItems() {
//        let closeNavigationItem = UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
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
