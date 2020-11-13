//
//  MTNavigationController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

class MTNavigationController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override internal func buildSubviews() {
        
        self.configureNavigationBar(transparent: true)
    }
    
    public func configureNavigationBar(transparent: Bool){
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        
        if(!transparent){
            self.navigationBar.barTintColor = ColorPalette.colorWhite
        }

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
