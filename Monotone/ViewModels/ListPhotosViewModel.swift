//
//  SearchPhotosViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation

import RxSwift
import Action

class ListPhotosViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: Input
    struct Input {
        var orderBy: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input:Input = Input()
    
    // MARK: Output
    struct Output {
        var photos: BehaviorSubject<[Photo]> = BehaviorSubject<[Photo]>(value: [])
        var loadingMore: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
        var reloading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    }
    public var output: Output = Output()
    
    // MARK: Private
    private var nextLoadPage: Int = 1
    
    // MARK: Inject
    override func inject(args: [String : Any]?) {
        if(args?["orderBy"] != nil){
            self.input.orderBy = BehaviorSubject<String>(value: args!["orderBy"] as? String ?? "")
        }
    }
    
    // MARK: Bind
    override func bind() {
        
        // Service.
        let photoService = self.service(type: PhotoService.self)
                
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.output.loadingMore.onNext(true)
            
            guard let orderBy = try? self.input.orderBy.value() else { return .empty() }
            return photoService!.listPhotos(page: self.nextLoadPage, orderBy: orderBy)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { (photos: [Photo]) in

                if let value = try? self.output.photos.value(){
                    self.output.photos.onNext(value + photos)
                    self.nextLoadPage += 1
                }
                
                self.output.loadingMore.onNext(false)
            }, onError: { (error) in
                
                self.output.loadingMore.onNext(false)
            }).disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.nextLoadPage = 1
            return self.input.loadMoreAction!.execute()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { (photos: [Photo]) in
                
                self.output.photos.onNext(photos)
                self.output.reloading.onNext(false)
            }, onError: { (error) in
                
                self.output.reloading.onNext(false)
            }).disposed(by: self.disposeBag)
    }
}
