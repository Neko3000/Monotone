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
        self.backgroundColor = ColorPalette.colorWhite
        
        // TitleLabel.
        self.titleLabel = UILabel()
        

    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        
    }
}
