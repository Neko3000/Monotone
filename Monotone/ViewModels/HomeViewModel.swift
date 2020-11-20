//
//  HomeViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/19.
//

import Foundation

import RxSwift
import RxRelay
import Action

class HomeViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: Input
    struct Input {
        var searchQuery: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var orderBy: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input: Input = Input()
    
    // MARK: Output
    struct Output {
        var photos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        var loadingMore: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        var reloading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    }
    public var output: Output = Output()
    
    // MARK: Private
    private var nextLoadPage: Int = 1
    
    // MARK: Inject
    override func inject(args: [String : Any]?) {
        if(args?["searchQuery"] != nil){
            self.input.searchQuery = BehaviorRelay(value: args!["searchQuery"] as! String)
        }
        if(args?["orderBy"] != nil){
            self.input.orderBy = BehaviorRelay(value: args!["orderBy"] as! String)
        }
    }
    
    // MARK: Bind
    override func bind() {
        
        // Service
        let photoService = self.service(type: PhotoService.self)
        
        // Binding
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.output.loadingMore.accept(true)
            
            if(self.input.orderBy.value != ""){
                return photoService!.listPhotos(page: self.nextLoadPage, orderBy: self.input.orderBy.value)
            }
            else if(self.input.searchQuery.value != ""){
                return photoService!.searchPhotos(query: self.input.searchQuery.value , page: self.nextLoadPage)
            }
            else{
                self.output.loadingMore.accept(false)
            }
            
            return Observable.empty()
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { (photos: [Photo]) in
                
                self.output.photos.accept(self.nextLoadPage == 1 ? photos : self.output.photos.value + photos)
                self.nextLoadPage += 1
                
                self.output.loadingMore.accept(false)
            }, onError: { (error) in
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.nextLoadPage = 1
            return self.input.loadMoreAction!.execute()
        })
        
        self.input.reloadAction?.elements
            .subscribe(onNext: { (photos: [Photo]) in
                
                self.output.photos.accept(photos)
                self.output.reloading.accept(false)
            }, onError: { (error) in
                
                self.output.reloading.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Order by.
        self.input.orderBy
            .distinctUntilChanged()
            .filter({ $0 != "" })
            .subscribe { (_) in
                self.input.searchQuery.accept("")
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
        
        // Search query.
        self.input.searchQuery
            .distinctUntilChanged()
            .filter({ $0 != "" })
            .subscribe { (_) in
                self.input.orderBy.accept("")
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
    
        
    }
    
    
}
