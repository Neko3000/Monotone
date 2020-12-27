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
        var likePhotoAction: Action<Void,Photo>?
        var unlikePhotoAction: Action<Void,Photo>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private

    
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
        self.input.likePhotoAction = Action<Void,Photo>(workFactory: { (_) -> Observable<Photo> in
            
            if let photo = self.output.photo.value{
                return photoService.likePhoto(id: photo.id!)
            }
            
            return Observable.empty()
        })
        
        self.input.likePhotoAction?.elements
            .subscribe(onNext: { [weak self] (photo) in
                guard let self = self else { return }

                self.output.photo.accept(photo)
            })
            .disposed(by: self.disposeBag)
        
        self.input.unlikePhotoAction = Action<Void,Photo>(workFactory: { (_) -> Observable<Photo> in
            
            if let photo = self.output.photo.value{
                return photoService.unlikePhoto(id: photo.id!)
            }
            
            return Observable.empty()
        })
        
        self.input.unlikePhotoAction?.elements
            .subscribe(onNext: { [weak self] (photo) in
                guard let self = self else { return }

                self.output.photo.accept(photo)
            })
            .disposed(by: self.disposeBag)
        
    }
}
