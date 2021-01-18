//
//  CollectionsViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/18.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

import anim
import ViewAnimator

// MARK: - CollectionsViewController
class CollectionsViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var topGradientImageView: UIImageView!
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
    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.text = NSLocalizedString("uns_made_with_uns_title", comment: "Made with Unsplash")
        self.titleLabel.numberOfLines = 0
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.text = NSLocalizedString("uns_made_with_uns_description", comment: "Showcasing the best things being made with Unsplash.")
        self.descriptionLabel.numberOfLines = 0
                
        // TableView.
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(CollectionsTableViewCell.self, forCellReuseIdentifier: "CollectionsTableViewCell")
        self.tableView.estimatedSectionHeaderHeight = 172.0
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.view).offset(-18.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // MJRefresh.
        let header = MJRefreshNormalHeader()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.tableView.mj_footer = footer
        
        // TopGradientView.
//        self.topGradientImageView = UIImageView()
//        self.topGradientImageView.image = UIImage(named: "list-top-gradient")
//        self.view.addSubview(self.topGradientImageView)
//        self.topGradientImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.tableView)
//            make.right.left.equalTo(self.view)
//            make.height.equalTo(92.0)
//        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let collectionsViewModel = self.viewModel(type:CollectionsViewModel.self)!

        // Bindings.
        // CollectionView.
        collectionsViewModel.output.collections
            .bind(to: self.tableView.rx.items(cellIdentifier: "CollectionsTableViewCell")){
                (row, element, cell) in
                
                let pcell: CollectionsTableViewCell = cell as! CollectionsTableViewCell
                pcell.collection.accept(element)
            
            }
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.modelSelected(Photo.self)
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .push(scene: .photoDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)

        // MJRefresh.
        self.tableView.mj_header!.refreshingBlock = {
            collectionsViewModel.input.reloadAction?.execute()
        }
            
        self.tableView.mj_footer!.refreshingBlock = {
            collectionsViewModel.input.loadMoreAction?.execute()
        }
        
        collectionsViewModel.output.reloading
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.tableView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)

        collectionsViewModel.output.loadingMore
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }

                self.tableView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // First loading.
        collectionsViewModel.input.loadMoreAction?.execute()
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
extension CollectionsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        header.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(header)
        }
        
        header.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            make.right.left.equalTo(header)
            make.bottom.equalTo(header).offset(-42.0)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
}
