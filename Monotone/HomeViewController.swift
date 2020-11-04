//
//  HomeViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit

class HomeViewController: MTViewController {
    
    private var homeHeaderView : HomeHeaderView?
    private var photoTableView : UITableView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        self.homeHeaderView = HomeHeaderView()
        self.view.addSubview(self.homeHeaderView!)
        self.homeHeaderView!.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(256.0);
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
