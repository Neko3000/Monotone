//
//  PhotoAddCollectionViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
import Kingfisher
import MJRefresh

// MARK: - PhotoAddCollectionViewController
class PhotoAddCollectionViewController: BaseViewController {
    
    // MARK: - Controls
    private var pageTitleView: PageTitleView!

    private var tableView: UITableView!
    private var createCollectionBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.white
        
        // pageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
            make.height.equalTo(50.0)
        }
        
        // tableView.
        self.tableView = UITableView()
        self.tableView.separatorStyle = .none
        self.tableView.register(AddCollectionTableViewCell.self, forCellReuseIdentifier: "AddCollectionTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(21.0)
            make.bottom.equalTo(self.view).offset(-96.0)
        }
        
        // addCollectionBtn.
        self.createCollectionBtn = UIButton()
        self.createCollectionBtn.backgroundColor = ColorPalette.colorGrayLighter
        self.createCollectionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.createCollectionBtn.setTitleColor(ColorPalette.colorGrayLight, for: .normal)
        self.createCollectionBtn.setTitle("Create a new collection", for: .normal)
        self.view.addSubview(self.createCollectionBtn)
        self.createCollectionBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.right.equalTo(self.view).offset(-17.0)
            make.top.equalTo(self.tableView.snp.bottom).offset(20.0)
            make.height.equalTo(50.0)
        }
        
        // MJRefresh.
        let header = MJRefreshNormalHeader()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.tableView.mj_footer = footer
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let photoAddCollectionViewModel = self.viewModel(type: PhotoAddCollectionViewModel.self)!
        
        // Bindings.
        photoAddCollectionViewModel.output.collections
            .bind(to: self.tableView.rx.items(cellIdentifier: "AddCollectionTableViewCell")){
                (row, element, cell) in
                
                let pcell: AddCollectionTableViewCell = cell as! AddCollectionTableViewCell
                pcell.collection.accept(element)
            }
            .disposed(by: self.disposeBag)
        
        // pageTitleView.
        self.pageTitleView.title.accept(NSLocalizedString("unsplash_add_collection_title", comment: "Add to collection"))
        
        // MJRefresh.
        self.tableView.mj_header!.refreshingBlock = {
            photoAddCollectionViewModel.input.reloadAction?.execute()
        }
            
        self.tableView.mj_footer!.refreshingBlock = {
            photoAddCollectionViewModel.input.loadMoreAction?.execute()
        }
        
        photoAddCollectionViewModel.output.reloading
            .filter({ $0 == false })
            .subscribe { (_) in
                self.tableView.mj_header!.endRefreshing()
                
                // Scroll to top.
                self.tableView.setContentOffset(.zero, animated: true)
            }
            .disposed(by: self.disposeBag)

        photoAddCollectionViewModel.output.loadingMore
            .filter({ $0 == false })
            .subscribe { (_) in
                self.tableView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // createCollectionBtn.
        self.createCollectionBtn.rx.tap.subscribe(onNext: { _ in

            self.transition(type: .present(.photoCreateCollection(nil), .pageSheet), with: nil, animated: true)
        })
        .disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // First Loading.
         self.tableView.mj_header?.beginRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Create dashed border for createCollectionBtn.
        self.createCollectionBtn.applyDashedBorder(color: ColorPalette.colorGrayLight, cornerRadius: 8.0)
    }
}

// MARK: - UITableViewDelegate
extension PhotoAddCollectionViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
}

// MARK: - ViewControllerPresentable
extension PhotoAddCollectionViewController: ViewControllerPresentable{
    
    func didDismissPresentingViewController(presentationController: UIPresentationController?) {
        
        // Reloading.
        self.tableView.mj_header?.beginRefreshing()
    }
}
