//
//  SideMenuOptionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import Foundation

import RxSwift
import RxRelay
import RxCocoa

// MARK: - SideMenuOptionView
class SideMenuOptionView: BaseView{
    
    // MARK: Public
    
    // MARK: Controls
    private var tableView: UITableView!
    
    private var horizontalTopLineLong: UIView!
    private var horizontalTopLineShort: UIView!
    private var horizontalBottomLineLong: UIView!
    private var horizontalBottomLineShort: UIView!
    
    private var optionContent: [String] {
        return [
            NSLocalizedString("unsplash_side_menu_option_my_photos", comment: "My Photos"),
            NSLocalizedString("unsplash_side_menu_option_hiring", comment: "Hiring"),
            NSLocalizedString("unsplash_side_menu_option_licenses", comment: "Licenses"),
            NSLocalizedString("unsplash_side_menu_option_help", comment: "Help"),
            NSLocalizedString("unsplash_side_menu_option_made_with_unsplash", comment: "Made with Unsplash"),
        ]
    }
        
    // MARK: Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func buildSubviews() {
        super.buildSubviews()
        
        // tableView.
        self.tableView = UITableView()
        self.tableView.separatorStyle = .none
        self.tableView.register(SideMenuOptionTableViewCell.self, forCellReuseIdentifier: "SideMenuOptionTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(20.0)
            make.bottom.equalTo(self).offset(-20.0)
        }
        
        // horizontalTopLineLong.
        self.horizontalTopLineLong = UIView()
        self.horizontalTopLineLong.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalTopLineLong)
        self.horizontalTopLineLong.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.height.equalTo(1.0)
            make.width.equalTo(53.0)
        }
        
        // horizontalTopLineShort.
        self.horizontalTopLineShort = UIView()
        self.horizontalTopLineShort.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalTopLineShort)
        self.horizontalTopLineShort.snp.makeConstraints { (make) in
            make.left.equalTo(self.horizontalTopLineLong.snp.right).offset(8.0)
            make.top.equalTo(self)
            make.height.equalTo(1.0)
            make.width.equalTo(8.0)
        }
        
        // horizontalBottomLineLong.
        self.horizontalBottomLineLong = UIView()
        self.horizontalBottomLineLong.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalBottomLineLong)
        self.horizontalBottomLineLong.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.height.equalTo(1.0)
            make.width.equalTo(53.0)
        }
        
        // horizontalBottomLineShort.
        self.horizontalBottomLineShort = UIView()
        self.horizontalBottomLineShort.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalBottomLineShort)
        self.horizontalBottomLineShort.snp.makeConstraints { (make) in
            make.right.equalTo(self.horizontalBottomLineLong.snp.left).offset(-8.0)
            make.top.equalTo(self)
            make.height.equalTo(1.0)
            make.width.equalTo(8.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        
    }
}

// MARK: - UITableViewDelegate
extension SideMenuOptionView: UITableViewDelegate{
    
}
