//
//  StoreViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/6.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

// MARK: - StoreViewController
class StoreViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var headerView: StoreHeaderView!
    private var bannerView: StoreBannerView!
    
    private var tableView: UITableView!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // HeaderView.
        self.headerView = StoreHeaderView()
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalTo(self.view)
            make.height.equalTo(90.0)
        }
        
        // BannerView.
        self.bannerView = StoreBannerView()
        self.view.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(24.0)
            make.left.right.equalTo(self.view)
            make.height.equalTo(217.0)
        }

        // TableView.
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(MadeWithUnsplashTableViewCell.self, forCellReuseIdentifier: "MadeWithUnsplashTableViewCell")
        self.tableView.estimatedSectionHeaderHeight = 172.0
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bannerView.snp.bottom).offset(27.0)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        
        // Bindings.
        
        
        //
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

extension StoreViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 297.0
    }
}
