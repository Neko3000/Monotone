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
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
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
    override func inject(args: [String : Any]?) {
        if let photo = args?["photo"]{
            self.input.photo = BehaviorRelay(value: photo as? Photo)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let photoService = self.service(type: PhotoService.self)!
        
        // Bindings.
        self.input.photo
            .unwrap()
            .flatMap { (photo) -> Observable<Statistics> in
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
