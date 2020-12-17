//
//  BaseNavigationController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

class BaseNavigationController: UINavigationController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buildSubviews()
        self.buildLogic()
    }
    
    func buildSubviews() {
        // Implemented by subclass.
    }
    
    func buildLogic() {
        // Implemented by subclass.
    }
    
    func updateNavBarTransparent(transparent: Bool) {
        // Implemented by subclass.
    }
    
    func updateNavBarHidden(hidden: Bool) {
        // Implemented by subclass.
    }
    
    func updateNavItems(color: UIColor? = nil, leftItems: [UIBarButtonItem]? = nil, rightItems: [UIBarButtonItem]? = nil) {
        // Implemented by subclass.
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
