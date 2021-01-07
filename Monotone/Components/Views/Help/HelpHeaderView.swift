//
//  HelpHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/6.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class HelpHeaderView: BaseView {
    
    // MARK: - Public

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var keywordSearchBar: UISearchBar!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // 
        self.backgroundColor = UIColor.black
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        self.titleLabel.text = "Advice and Answers from the Unsplash Team"
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12.0)
            make.right.equalTo(self).offset(-138.0)
            make.left.equalTo(self).offset(18.0)
        }
        
        // KeywordSearchBar.
        self.keywordSearchBar = UISearchBar()
        self.keywordSearchBar.backgroundColor = UIColor.white
        self.keywordSearchBar.searchTextPositionAdjustment = UIOffset(horizontal: 15.0, vertical: 0)
        self.keywordSearchBar.setImage(UIImage(named: "header-input-search"), for: .search, state: .normal)
        self.keywordSearchBar.placeholder = "Search for Articles…"
        self.keywordSearchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        self.keywordSearchBar.layer.cornerRadius = 4.0
        self.keywordSearchBar.layer.masksToBounds = true
        self.addSubview(self.keywordSearchBar)
        self.keywordSearchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15.0)
            make.right.equalTo(self).offset(-15.0)
            make.bottom.equalTo(self).offset(-24.0)
            make.height.equalTo(54.0)
        }
    
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        
    }
}
