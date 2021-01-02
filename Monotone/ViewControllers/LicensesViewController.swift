//
//  LicensesViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/29.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

import anim
import ViewAnimator

// MARK: - LicensesViewController
class LicensesViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    private var headerLabel: UILabel!
    private var contentLabel: UILabel!

    
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
        
        // ScrollView.
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(10.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.view).offset(-120.0)
            make.bottom.equalTo(self.view)
        }
        
        // StackView.
        self.stackView = UIStackView()
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .vertical
        self.stackView.spacing = 0
        self.scrollView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { (make) in
            make.width.equalTo(self.scrollView)
            make.top.right.bottom.left.equalTo(self.scrollView)
        }
                
        // HeaderLabel.
        self.headerLabel = UILabel()
        self.headerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.headerLabel.textColor = ColorPalette.colorBlack
        self.headerLabel.text = NSLocalizedString("unsplash_hiring_header", comment: "Help build a creative movement.")
        self.headerLabel.numberOfLines = 0
        self.stackView.addArrangedSubview(self.headerLabel)
//        self.headerLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self.containerView).offset(10.0)
//            make.left.equalTo(self.containerView).offset(18.0)
//            make.right.equalTo(self.containerView).offset(-120.0)
//        }
        
        // ContentLabel.
        let attributedContent = NSMutableAttributedString(string: NSLocalizedString("unsplash_hiring_section_content", comment: "If you want to work with us, all we want to see is a message from you. Please don’t send a resume. Instead, tell us who you are. Show us relevant things you’ve done that you’re excited about."))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 30.0
        
        attributedContent.addAttribute(NSAttributedString.Key.paragraphStyle,value: paragraphStyle, range: NSMakeRange(0, attributedContent.length))
        
        self.contentLabel = UILabel()
        self.contentLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentLabel.textColor = ColorPalette.colorBlack
        self.contentLabel.numberOfLines = 0
        self.contentLabel.attributedText = attributedContent
        self.stackView.addArrangedSubview(self.contentLabel)
//        self.contentLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self.headerLabel.snp.bottom).offset(12.0)
//            make.left.equalTo(self.containerView).offset(18.0)
//            make.right.equalTo(self.containerView).offset(-120.0)
//            make.bottom.equalTo(self.containerView).offset(-20.0)
//        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        //
        
        // Bindings.
        //
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
