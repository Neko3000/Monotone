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
    
    private var headerLabel: UILabel!
    private var descriptionLabel: UILabel!
    
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
        
        // HeaderLabel.
        self.headerLabel = UILabel()
        self.headerLabel.textColor = ColorPalette.colorBlack
        self.headerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.headerLabel.text = "Made with Unsplash"
        self.headerLabel.numberOfLines = 0
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(12.0)
            make.right.equalTo(self.view).offset(-138.0)
            make.left.equalTo(self.view).offset(18.0)
        }
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.text = "Showcasing the best things being made with Unsplash."
        self.descriptionLabel.numberOfLines = 0
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(12.0)
            make.right.equalTo(self.view).offset(-138.0)
            make.left.equalTo(self.view).offset(18.0)
        }
                
        // TableView.
        self.tableView = UITableView()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(MadeWithUnsplashTableViewCell.self, forCellReuseIdentifier: "MadeWithUnsplashTableViewCell")
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
        // MadeCategory.
        madeWithUnsplashViewModel.input.categories
            .accept(MadeCategory.allCases)
        
        // CategorySelectionView.
        madeWithUnsplashViewModel.output.categories
            .unwrap()
            .subscribe(onNext:{ [weak self] (categories) in
                guard let self = self else { return }
                
                self.categorySelectionView.items.accept(categories.map({ return (key: $0, value: $0.rawValue.title) }))
            })
            .disposed(by: self.disposeBag)
        
        self.categorySelectionView.selectedItem
            .unwrap()
            .subscribe(onNext:{ (item) in
                let category = item.key as! MadeCategory
                madeWithUnsplashViewModel.input.selectedCategory.accept(category)
            })
            .disposed(by: self.disposeBag)
        
        // TableView cell.
        madeWithUnsplashViewModel.output.madeItems
            .unwrap()
            .bind(to: self.tableView.rx.items(cellIdentifier: "MadeWithUnsplashTableViewCell")){
                (row, element, cell) in
                
                let pcell: MadeWithUnsplashTableViewCell = cell as! MadeWithUnsplashTableViewCell
                pcell.madeItem.accept(element)
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 469.0
    }
}
