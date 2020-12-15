//
//  PhotoDetailsViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoDetailsViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
        var likePhotoAction: Action<Void,Photo>?
        var unlikePhotoAction: Action<Void,Photo>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: Private

    
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
        
        // Binding.
        (self.input.photo <=> self.output.photo)
            .disposed(by: self.disposeBag)
        
        self.input.likePhotoAction = Action<Void,Photo>(workFactory: { (_) -> Observable<Photo> in
            
            if let photo = self.input.photo.value{
                return photoService.likePhoto(id: photo.id!)
            }
            
            return Observable.empty()
        })
        
        self.input.likePhotoAction?.elements
            .subscribe(onNext: { (photo) in
                self.input.photo.accept(photo)
            })
            .disposed(by: self.disposeBag)
        
        self.input.unlikePhotoAction = Action<Void,Photo>(workFactory: { (_) -> Observable<Photo> in
            
            if let photo = self.input.photo.value{
                return photoService.unlikePhoto(id: photo.id!)
            }
            
            return Observable.empty()
        })
        
        self.input.unlikePhotoAction?.elements
            .subscribe(onNext: { (photo) in
                self.input.photo.accept(photo)
            })
            .disposed(by: self.disposeBag)
        
    }
}
