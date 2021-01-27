//
//  ExploreViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/24.
//

import UIKit

import SnapKit
import MJRefresh
import Kingfisher

import RxSwift
import RxRelay
import RxSwiftExt
import RxDataSources

import anim
import ViewAnimator

// MARK: - ExploreViewController
class ExploreViewController: BaseViewController {
    
    // MARK: - Public
    //
    
    // MARK: - Controls
    private var headerView: ExploreHeaderView!
    
    private var dataSource:RxTableViewSectionedReloadDataSource<TableViewSection>!
    private var tableView: UITableView!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        let animation = AnimationType.zoom(scale: 0.2)
//        UIView.animate(views: self.collectionView.visibleCells, animations: [animation], reversed: false, initialAlpha: 0, finalAlpha: 1.0, delay: 1.0, animationInterval: 0.8, duration: 0.8, options: .curveEaseInOut, completion: nil)
    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // HeaderView.
        self.headerView = ExploreHeaderView()
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view)
            make.height.equalTo(140.0)
        }
        
        // TableView.
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(ExplorePhotoTableViewCell.self, forCellReuseIdentifier: "ExplorePhotoTableViewCell")
        self.tableView.register(CollectionsTableViewCell.self, forCellReuseIdentifier: "CollectionsTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(27.0)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let exploreViewModel = self.viewModel(type:ExploreViewModel.self)!

        // Bindings.
        // CollectionView.
        self.dataSource = RxTableViewSectionedReloadDataSource<TableViewSection>(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            var cell: UITableViewCell? = nil
            
            if(exploreViewModel.input.explore.value == .explore){
                let pcell = tableView.dequeueReusableCell(withIdentifier: "ExplorePhotoTableViewCell", for: indexPath) as! ExplorePhotoTableViewCell
                pcell.photoType.accept(item as? ExplorePhotoType)
                
                cell = pcell
            }
            else if(exploreViewModel.input.explore.value == .popular){
                let pcell = tableView.dequeueReusableCell(withIdentifier: "CollectionsTableViewCell", for: indexPath) as! CollectionsTableViewCell
                pcell.alignToRight = !(indexPath.row % 2 == 0)
                pcell.collection.accept(item as? Collection)

                cell = pcell
            }
            
            return cell!
        })
        
        exploreViewModel.output.sections
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        
        // HeaderView.
        self.headerView.explore
            .bind(to: exploreViewModel.input.explore)
            .disposed(by: self.disposeBag)
        
        self.headerView.explore.accept(.explore)
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

// MARK: - UITableViewDelegate
extension ExploreViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
            
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = ColorPalette.colorBlack
        titleLabel.text = self.dataSource[section].title
        titleLabel.numberOfLines = 0
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerView)
            make.left.equalTo(headerView).offset(18.0)
            make.right.equalTo(headerView).offset(-18.0)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = ColorPalette.colorGrayLight
        descriptionLabel.text = self.dataSource[section].description
        descriptionLabel.numberOfLines = 0
        headerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(6.0)
            make.left.equalTo(headerView).offset(18.0)
            make.right.equalTo(headerView).offset(-18.0)
            make.bottom.equalTo(headerView).offset(-22.0)
        }

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.headerView.explore.value == .explore){
            return 252.0
        }
        else if(self.headerView.explore.value == .popular){
            return 303.0
        }
        
        return 0
    }
}
