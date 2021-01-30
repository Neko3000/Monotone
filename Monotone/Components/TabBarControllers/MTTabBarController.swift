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
        super.buildSubviews()
        
        self.tabBar.tintColor = ColorPalette.colorBlack
        
        self.tabBar.barTintColor = UIColor.clear
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        
        self.tabBarBackgroundView = UIView()
        self.tabBarBackgroundView.backgroundColor = ColorPalette.colorWhite
        self.view.insertSubview(self.tabBarBackgroundView, belowSubview: self.tabBar)
        self.tabBarBackgroundView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-InterfaceValues.tabBarHeight)
        }
                
        self.addBtn = UIButton()
        
        self.addBtn.setImage(UIImage(named: "add-item-btn"), for: .normal)
        self.view.addSubview(self.addBtn)
        self.addBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tabBarBackgroundView.snp.top)
            make.centerX.equalTo(self.tabBarBackgroundView.snp.right).multipliedBy(3.5/4)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first{
            let height: CGFloat = window.safeAreaInsets.bottom + InterfaceValues.tabBarHeight
            let width: CGFloat = self.view.frame.size.width * (3.0 / 4)
            
            var tabFrame = self.tabBar.frame
            let originTabHeight = tabFrame.height
            
            tabFrame.size.width = width
            tabFrame.size.height = height
            tabFrame.origin.y = self.view.frame.size.height - height
            self.tabBar.frame = tabFrame
            
            var safeArea = UIEdgeInsets()
            safeArea.bottom += (height - originTabHeight)
            self.viewControllers?.forEach({$0.additionalSafeAreaInsets = safeArea})
        }
        
        self.updateTabBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    private func updateTabBar() {
        let path = UIBezierPath(roundedRect: self.tabBarBackgroundView.bounds, cornerRadius: 0)
        
        let cropPath = UIBezierPath()
        
        let centerX = self.tabBarBackgroundView.bounds.width * (3.5/4)
        let offsetX = self.addBtn.bounds.width / 2.0
        let margin: CGFloat = 7.0
        
        let beginPoint = CGPoint(x: centerX - offsetX - margin, y: 0)
        cropPath.move(to: beginPoint)
        cropPath.addLine(to: CGPoint(x: centerX + offsetX + margin, y: 0))
        cropPath.addLine(to: CGPoint(x: centerX, y: offsetX + margin))
        cropPath.close()
        
        path.append(cropPath)
        path.usesEvenOddFillRule = true
        
        let maskShapeLayer = CAShapeLayer()
        maskShapeLayer.frame = self.tabBarBackgroundView.bounds
        maskShapeLayer.fillRule = .evenOdd

        maskShapeLayer.path = path.cgPath
        // shapeLayer.fillRule = .evenOdd
        
        self.tabBarBackgroundView.layer.mask = maskShapeLayer
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
