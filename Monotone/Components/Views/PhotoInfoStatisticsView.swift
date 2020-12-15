//
//  PhotoInfoStatisticsView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class PhotoInfoStatisticsView: BaseView {
    
    // MARK: Public
    public var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)
    
    /*
    public var viewCount: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var likeCount: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var downloadCount: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    */
    
    // MARK: Controls
    private var viewCountImageView: UIImageView!
    private var viewCountLabel: UILabel!
    private var viewCountCompareLabel: UILabel!
    private var viewSinceLastMonthLabel: UILabel!
    
    private var likeCountImageView: UIImageView!
    private var likeCountLabel: UILabel!
    private var likeCountCompareLabel: UILabel!
    private var likeSinceLastMonthLabel: UILabel!
    
    private var downloadCountImageView: UIImageView!
    private var downloadCountLabel: UILabel!
    private var downloadCountCompareLabel: UILabel!
    private var downloadSinceLastMonthLabel: UILabel!
    
    // MARK: Private
    private let disposeBag: DisposeBag = DisposeBag()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        self.viewCountImageView = UIImageView()
        self.viewCountImageView.image = UIImage(named: "info-view")
        self.addSubview(self.viewCountImageView)
        self.viewCountImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.height.equalTo(30.0)
        }
        
        self.viewCountLabel = UILabel()
        self.viewCountLabel.text = "660,031"
        self.viewCountLabel.textColor = ColorPalette.colorBlack
        self.viewCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.addSubview(self.viewCountLabel)
        self.viewCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewCountImageView.snp.bottom)
            make.centerX.equalTo(self.viewCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)

        }
        
        self.viewCountCompareLabel = UILabel()
        self.viewCountCompareLabel.text = "+173,817"
        self.viewCountCompareLabel.textColor = ColorPalette.colorBlack
        self.viewCountCompareLabel.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(self.viewCountCompareLabel)
        self.viewCountCompareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewCountLabel.snp.bottom).offset(4.0)
            make.centerX.equalTo(self.viewCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)
        }
        
        self.viewSinceLastMonthLabel = UILabel()
        self.viewSinceLastMonthLabel.text = NSLocalizedString("unsplash_info_since_to_last_month", comment: "since last month")
        self.viewSinceLastMonthLabel.textColor = ColorPalette.colorGrayLight
        self.viewSinceLastMonthLabel.font = UIFont.systemFont(ofSize: 8)
        self.addSubview(self.viewSinceLastMonthLabel)
        self.viewSinceLastMonthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewCountCompareLabel.snp.bottom).offset(2.0)
            make.centerX.equalTo(self.viewCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)

        }
        
        self.likeCountImageView = UIImageView()
        self.likeCountImageView.image = UIImage(named: "info-like")
        self.addSubview(self.likeCountImageView)
        self.likeCountImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(1/3.0)
            make.centerX.equalTo(self)
            make.width.height.equalTo(30.0)
        }
        
        self.likeCountLabel = UILabel()
        self.likeCountLabel.text = "1455"
        self.likeCountLabel.textColor = ColorPalette.colorBlack
        self.likeCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.addSubview(self.likeCountLabel)
        self.likeCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeCountImageView.snp.bottom)
            make.centerX.equalTo(self.likeCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)

        }
        
        self.likeCountCompareLabel = UILabel()
        self.likeCountCompareLabel.text = "+1817"
        self.likeCountCompareLabel.textColor = ColorPalette.colorBlack
        self.likeCountCompareLabel.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(self.likeCountCompareLabel)
        self.likeCountCompareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeCountLabel.snp.bottom).offset(4.0)
            make.centerX.equalTo(self.likeCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)
        }
        
        self.likeSinceLastMonthLabel = UILabel()
        self.likeSinceLastMonthLabel.text = NSLocalizedString("unsplash_info_since_to_last_month", comment: "since last month")
        self.likeSinceLastMonthLabel.textColor = ColorPalette.colorGrayLight
        self.likeSinceLastMonthLabel.font = UIFont.systemFont(ofSize: 8)
        self.addSubview(self.likeSinceLastMonthLabel)
        self.likeSinceLastMonthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likeCountCompareLabel.snp.bottom).offset(2.0)
            make.centerX.equalTo(self.likeCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)

        }
        
        self.downloadCountImageView = UIImageView()
        self.downloadCountImageView.image = UIImage(named: "info-download")
        self.addSubview(self.downloadCountImageView)
        self.downloadCountImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).multipliedBy(2/3.0)
            make.centerX.equalTo(self)
            make.width.height.equalTo(30.0)
        }
        
        self.downloadCountLabel = UILabel()
        self.downloadCountLabel.text = "79"
        self.downloadCountLabel.textColor = ColorPalette.colorBlack
        self.downloadCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.addSubview(self.downloadCountLabel)
        self.downloadCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.downloadCountImageView.snp.bottom)
            make.centerX.equalTo(self.downloadCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)

        }
        
        self.downloadCountCompareLabel = UILabel()
        self.downloadCountCompareLabel.text = "+17"
        self.downloadCountCompareLabel.textColor = ColorPalette.colorBlack
        self.downloadCountCompareLabel.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(self.downloadCountCompareLabel)
        self.downloadCountCompareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.downloadCountLabel.snp.bottom).offset(4.0)
            make.centerX.equalTo(self.downloadCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)
        }
        
        self.downloadSinceLastMonthLabel = UILabel()
        self.downloadSinceLastMonthLabel.text = NSLocalizedString("unsplash_info_since_to_last_month", comment: "since last month")
        self.downloadSinceLastMonthLabel.textColor = ColorPalette.colorGrayLight
        self.downloadSinceLastMonthLabel.font = UIFont.systemFont(ofSize: 8)
        self.addSubview(self.downloadSinceLastMonthLabel)
        self.downloadSinceLastMonthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.downloadCountCompareLabel.snp.bottom).offset(2.0)
            make.centerX.equalTo(self.downloadCountImageView)
            make.left.greaterThanOrEqualTo(self.snp.left).offset(10.0)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-10.0)

        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings
        self.statistics
            .unwrap()
            .subscribe(onNext: { statistics in
                
                let numberFormatter = NumberFormatter()
                numberFormatter.usesGroupingSeparator = true
                numberFormatter.groupingSeparator = ","
                numberFormatter.groupingSize = 3

                if let viewCountTotal = statistics.views?.total{
                    self.viewCountLabel.text = numberFormatter.string(from: NSNumber(value: viewCountTotal))
                }
                if let likeCountTotal = statistics.likes?.total{
                    self.likeCountLabel.text = numberFormatter.string(from: NSNumber(value: likeCountTotal))
                }
                if let downloadCountTotal = statistics.downloads?.total{
                    self.downloadCountLabel.text = numberFormatter.string(from: NSNumber(value: downloadCountTotal))
                }
                
                numberFormatter.positivePrefix = "+"
                numberFormatter.negativePrefix = "-"
                
                if let viewCountChange = statistics.views?.historical?.change{
                    self.viewCountCompareLabel.text = numberFormatter.string(from: NSNumber(value: viewCountChange))
                }
                if let likeCountChange = statistics.likes?.historical?.change{
                    self.likeCountCompareLabel.text = numberFormatter.string(from: NSNumber(value: likeCountChange))
                }
                if let downloadCountChange = statistics.downloads?.historical?.change{
                    self.downloadCountCompareLabel.text = numberFormatter.string(from: NSNumber(value: downloadCountChange))
                }
        })
            .disposed(by: self.disposeBag)

    }
}
