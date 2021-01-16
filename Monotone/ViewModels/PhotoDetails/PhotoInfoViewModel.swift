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
import RxSwiftExt

class PhotoInfoViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        //
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
        var statistics: BehaviorRelay<Statistics?> = BehaviorRelay<Statistics?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if let photo = args?["photo"]{
            self.output.photo = BehaviorRelay(value: photo as? Photo)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let photoService = self.service(type: PhotoService.self)!
        
        // Bindings.
        self.output.photo
            .unwrap()
            .flatMap { (photo) -> Observable<Statistics> in
                return photoService.statisticizePhoto(id: photo.id!)
            }
            .subscribe(onNext: { [weak self] (statistics) in
                guard let self = self else { return }
            
                self.output.statistics.accept(statistics)
            })
            .disposed(by: self.disposeBag)
    }
    
}
