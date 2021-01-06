//
//  HelpViewController.swift
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

// MARK: - HelpViewController
class HelpViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    private var headerLabel: UILabel!
    private var contentLabel: UILabel!
    
    private var agreementSelectionView: PageSelectionView!

    
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
        
        // AgreementSelectionView.
        self.agreementSelectionView = PageSelectionView()
        self.view.addSubview(self.agreementSelectionView)
        self.agreementSelectionView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view).multipliedBy(1.0/3)
            make.width.equalTo(88.0)
            make.centerY.equalTo(self.view).offset(10.0)
            make.right.equalTo(self.view).offset(-19.0)
        }
        
        // ScrollView.
        self.scrollView = UIScrollView()
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.agreementSelectionView.snp.left).offset(-20.0)
            make.bottom.equalTo(self.view)
        }
        
        // StackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .vertical
        self.stackView.spacing = 24.0
        self.scrollView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.width.equalTo(self.scrollView)
            make.top.right.bottom.left.equalTo(self.scrollView)
        }
                
        // HeaderLabel.
        self.headerLabel = UILabel()
        self.headerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.headerLabel.textColor = ColorPalette.colorBlack
        self.headerLabel.numberOfLines = 0
        self.stackView.addArrangedSubview(self.headerLabel)
        
        // ContentLabel.
        self.contentLabel = UILabel()
        self.contentLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentLabel.textColor = ColorPalette.colorBlack
        self.contentLabel.numberOfLines = 0
        self.stackView.addArrangedSubview(self.contentLabel)
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let licensesViewModel = self.viewModel(type: LicensesViewModel.self)!

        // Bindings.
        // Agreements.
        licensesViewModel.input.aggrements
            .accept(UnsplashAgreement.allCases)
        
        // AgreementSelectionView.
        licensesViewModel.output.aggrements
            .unwrap()
            .subscribe(onNext:{ [weak self] (aggrements) in
                guard let self = self else { return }
                
                self.agreementSelectionView.items.accept(aggrements.map({ return (key: $0, value: $0.rawValue.title) }))
            })
            .disposed(by: self.disposeBag)
        
        self.agreementSelectionView.selectedItem
            .unwrap()
            .subscribe(onNext:{ [weak self] (item) in
                guard let self = self else { return }
                
                let agreement = item.key as! UnsplashAgreement
                
                self.headerLabel.text = agreement.rawValue.title
                
                let attributedContent = NSMutableAttributedString(string: agreement.rawValue.content)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 20.0
                
                attributedContent.addAttribute(NSAttributedString.Key.paragraphStyle,
                                               value: paragraphStyle,
                                               range: NSMakeRange(0, attributedContent.length))
                
                self.contentLabel.attributedText = attributedContent
            })
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
