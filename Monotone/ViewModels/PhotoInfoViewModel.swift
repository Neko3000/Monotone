//
//  PhotoInfoViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoInfoViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: Input
    struct Input {
        var photo: BehaviorRelay<Photo> = BehaviorRelay<Photo>(value: Photo())
    }
    public var input: Input = Input()
    
    // MARK: Output
    struct Output {
        var photo: BehaviorRelay<Photo> = BehaviorRelay<Photo>(value: Photo())
        var statistics: BehaviorRelay<Statistics> = BehaviorRelay<Statistics>(value: Statistics())
    }
    public var output: Output = Output()
    
    // MARK: Private

    
    // MARK: Inject
    override func inject(args: [String : Any]?) {
        if(args?["photo"] != nil){
            self.input.photo = BehaviorRelay(value: args!["photo"] as! Photo)
        }
    }
    
    // MARK: Bind
    override func bind() {
        
        // Service.
        let photoService = self.service(type: PhotoService.self)!
        
        // Bindings.
        self.input.photo.flatMap { (photo) -> Observable<Statistics> in
            return photoService.statisticizePhoto(id: photo.id!)
        }
        .subscribe(onNext: { (statistics) in
            
            self.output.statistics.accept(statistics)
        }, onError: { (error) in
            
        })
        .disposed(by: self.disposeBag)

        self.input.photo.bind(to: self.output.photo)
            .disposed(by: self.disposeBag)
        
    }
    
    
}
