//
//  MTTabBarController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/28.
//

import UIKit

class MTTabBarController: BaseTabBarController {
    
    // MARK: - Controls
    private var addBtn: UIButton!
    private var tabBarBackgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        self.tabBar.tintColor = ColorPalette.colorBlack
        
        self.tabBar.barTintColor = UIColor.clear
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        
        self.tabBarBackgroundView = UIView()
        self.tabBarBackgroundView.backgroundColor = ColorPalette.colorWhite
        self.view.insertSubview(self.tabBarBackgroundView, belowSubview: self.tabBar)
        self.tabBarBackgroundView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-InterfaceGlobalVars.tabBarHeight)
        }
                
        self.addBtn = UIButton()
        self.addBtn.backgroundColor = ColorPalette.colorBlack
        self.view.addSubview(self.addBtn)
        self.addBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tabBarBackgroundView.snp.top)
            make.centerX.equalTo(self.tabBarBackgroundView.snp.right).multipliedBy(3.5/4)
            make.width.height.equalTo(50.0)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first{
            let height: CGFloat = window.safeAreaInsets.bottom + InterfaceGlobalVars.tabBarHeight
            let width: CGFloat = self.view.frame.size.width * (3.0 / 4)
            
            var tabFrame = self.tabBar.frame
            tabFrame.size.width = width
            tabFrame.size.height = height
            tabFrame.origin.y = self.view.frame.size.height - height
            self.tabBar.frame = tabFrame
        }

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        var tabFrame = self.tabBar.frame
        tabFrame.size.width = 200
        tabFrame.size.height = 400
        tabFrame.origin.y = self.view.frame.size.height - 200
        self.tabBar.frame = tabFrame
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
