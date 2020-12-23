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
    private var pageView: SideMenuPageView!
    
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
            make.left.equalTo(self.view).offset(18.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(42.0)
        }
        
        // pageView.
        self.pageView = SideMenuPageView()
        self.view.addSubview(self.pageView)
        self.pageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileView.snp.bottom).offset(30.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.view).offset(-18.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-42.0)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let sideMenuViewModel = self.viewModel(type: SideMenuViewModel.self)!
        
        // Bindings.
        sideMenuViewModel.output.pages
            .bind(to: self.pageView.pages)
            .disposed(by: self.disposeBag)
        
        sideMenuViewModel.input.pages.accept(SideMenuPageVars.pages)
        
    }
    
}
