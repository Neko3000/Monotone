//
//  SearchPhotosViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation

import RxSwift
import Action

class SearchPhotosViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var query: BehaviorSubject<String> = BehaviorSubject<String>(value:"")
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input:Input = Input()
    
    // MARK: - Output
    struct Output {
        var photos: BehaviorSubject<[Photo]> = BehaviorSubject<[Photo]>(value: [])
        var loadingMore: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
        var reloading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var nextLoadPage: Int = 1
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if(args?["query"] != nil){
            self.input.query = BehaviorSubject<String>(value: args!["query"] as! String)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        let photoService = self.service(type: PhotoService.self)
                
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.output.loadingMore.onNext(true)
            
            guard let query = try? self.input.query.value() else { return .empty() }
            return photoService!.searchPhotos(query: query , page: self.nextLoadPage + 1)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }

                if let value = try? self.output.photos.value(){
                    self.output.photos.onNext(value + photos)
                    self.nextLoadPage += 1
                }
                
                self.output.loadingMore.onNext(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.nextLoadPage = 1
            return self.input.loadMoreAction!.execute()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { [weak self] (photos) in
                guard let self = self else { return }
                
                self.output.photos.onNext(photos)
                self.output.reloading.onNext(false)
            })
            .disposed(by: self.disposeBag)
    }
}
