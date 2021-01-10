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

import RxDataSources

// MARK: - StoreViewController
class StoreViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var headerView: StoreHeaderView!
    
    private var dataSource:RxTableViewSectionedReloadDataSource<TableViewSection>!
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

        // TableView.
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(StoreBannerTableViewCell.self, forCellReuseIdentifier: "StoreBannerTableViewCell")
        self.tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: "StoreTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(27.0)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let storeViewModel = self.viewModel(type: StoreViewModel.self)!

        // Bindings.
        // HeaderView.
        self.headerView.selectedCategory
            .bind(to: storeViewModel.input.selectedCategory)
            .disposed(by: self.disposeBag)
        
        // DataSource.
        self.dataSource = RxTableViewSectionedReloadDataSource<TableViewSection> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            var cell: UITableViewCell? = nil
            
            if(indexPath.section == 0){
                let pcell = tableView.dequeueReusableCell(withIdentifier: "StoreBannerTableViewCell", for: indexPath) as! StoreBannerTableViewCell
                pcell.storeItem.accept(item as? StoreItem)
                
                cell = pcell
            }
            else{
                let pcell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell", for: indexPath) as! StoreTableViewCell
                pcell.alignToRight = !(indexPath.row % 2 == 0)
                pcell.storeItem.accept(item as? StoreItem)
                
                cell = pcell
            }
            
            return cell!
        }
        
        self.dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }
        
        // TableView Cell.
        storeViewModel.output.sections
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        
        // First selection.
        self.headerView.selectedCategory.accept(.home)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 0){
            return 0
        }
        else{
            return 52.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if(section == 0){
            return nil
        }
        else{
            let headerView = UIView()

            let titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
            titleLabel.text = self.dataSource[section].header
            headerView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(headerView)
                make.left.right.equalTo(headerView).offset(13.0)
            }

            return headerView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
            return 217.0
        }
        else{
            return 303.0
        }
    }
}
