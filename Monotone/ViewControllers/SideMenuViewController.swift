//
//  SideMenuViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import UIKit

import RxSwift
import Kingfisher

// MARK: - SideMenuViewController
class SideMenuViewController: BaseViewController {
    
    // MARK: - Controls
    private var profileView: SideMenuProfileView!
    private var optionView: SideMenuOptionView!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.white
        
        // profileView.
        self.profileView = SideMenuProfileView()
        self.view.addSubview(self.profileView)
        self.profileView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).multipliedBy(1.0/2)
            make.top.equalTo(self.view).offset(42.0)
            make.left.right.equalTo(self.view)
        }
        
        // optionView.
        self.optionView = SideMenuOptionView()
        self.view.addSubview(self.optionView)
        self.optionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).multipliedBy(1.0/2)
            make.left.equalTo(self.view).offset(18.0)
            make.width.equalTo(self.view).offset(259.0)
            make.bottom.equalTo(self.view).offset(-53.0)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        
        // Bindings.
    }
    
}
