//
//  MadeWithUnsplashViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/8.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

// MARK: - MadeWithUnsplashViewController
class MadeWithUnsplashViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var tableView: UITableView!
    private var categorySelectionView: PageSelectionView!

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
        
        // CategorySelectionView.
        self.categorySelectionView = PageSelectionView()
        self.view.addSubview(self.categorySelectionView)
        self.categorySelectionView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view).multipliedBy(1.0/3)
            make.width.equalTo(88.0)
            make.centerY.equalTo(self.view).offset(10.0)
            make.right.equalTo(self.view).offset(-19.0)
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
            make.top.equalTo(self.view).offset(18.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.categorySelectionView.snp.left).offset(-20.0)
            make.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let madeWithUnsplashViewModel = self.viewModel(type: MadeWithUnsplashViewModel.self)!

        // Bindings.
        // MadeWithUnsplashCategory.
        madeWithUnsplashViewModel.input.categories
            .accept(MadeWithUnsplashCategory.allCases)
        
        // CategorySelectionView.
        madeWithUnsplashViewModel.input.categories
            .unwrap()
            .subscribe(onNext:{ [weak self] (categories) in
                guard let self = self else { return }
                
                self.categorySelectionView.items.accept(categories.map({ return (key: $0, value: $0.rawValue.title) }))
            })
            .disposed(by: self.disposeBag)
        
        self.categorySelectionView.selectedItem
            .unwrap()
            .subscribe(onNext:{ (item) in
                let category = item.key as! MadeWithUnsplashCategory
                madeWithUnsplashViewModel.input.selectedCategory.accept(category)
            })
            .disposed(by: self.disposeBag)
        
        // TableView cell.
        madeWithUnsplashViewModel.output.madeItems
            .unwrap()
            .bind(to: self.tableView.rx.items(cellIdentifier: "MadeWithUnsplashTableViewCell")){
                (row, element, cell) in
                
                let pcell: MadeWithUnsplashTableViewCell = cell as! MadeWithUnsplashTableViewCell
                pcell.madeWithUnsplashItem.accept(element)
    
            }
            .disposed(by: self.disposeBag)
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
extension MadeWithUnsplashViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        // TitleLabel.
        let titleLabel = UILabel()
        titleLabel.textColor = ColorPalette.colorBlack
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.text = NSLocalizedString("uns_made_with_uns_title", comment: "Made with Unsplash")
        titleLabel.numberOfLines = 0
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(headerView)
        }
        
        // DescriptionLabel.
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = ColorPalette.colorGrayLight
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.text = NSLocalizedString("uns_made_with_uns_description", comment: "Showcasing the best things being made with Unsplash.")
        descriptionLabel.numberOfLines = 0
        headerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.right.left.equalTo(headerView)
            make.bottom.equalTo(headerView).offset(-42.0)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 469.0
    }
}
