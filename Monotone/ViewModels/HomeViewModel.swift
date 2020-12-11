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
    
    // MARK: - Input
    struct Input {
        var searchQuery: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var listOrderBy: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var topic: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photos: BehaviorRelay<[Photo]> = BehaviorRelay<[Photo]>(value: [])
        var loadingMore: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        var reloading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    private var nextLoadPage: Int = 1
    private var emptyPhotos: [Photo] = Array.init(repeating: Photo(), count: 10)
    
    // MARK: - Inject
    override func inject(args: [String : Any]?) {
        if(args?["searchQuery"] != nil){
            self.input.searchQuery = BehaviorRelay(value: args!["searchQuery"] as! String)
        }
        if(args?["listOrderBy"] != nil){
            self.input.listOrderBy = BehaviorRelay(value: args!["listOrderBy"] as! String)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service
        let photoService = self.service(type: PhotoService.self)
        let topicService = self.service(type: TopicService.self)
        
        // Binding
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.output.loadingMore.accept(true)
            
            // Before the request returns.
            self.output.photos.accept(self.output.photos.value + self.emptyPhotos)
            
            if(self.input.listOrderBy.value != ""){
                return photoService!.listPhotos(page: self.nextLoadPage, perPage: 20, orderBy: self.input.listOrderBy.value)
            }
            else if(self.input.searchQuery.value != ""){
                return photoService!.searchPhotos(query: self.input.searchQuery.value , page: self.nextLoadPage, perPage: 20)
            }
            else if(self.input.topic.value != ""){
                return topicService!.getTopicPhotos(idOrSlug: self.input.topic.value, page: self.nextLoadPage, perPage: 20)
            }
            else{
                self.output.loadingMore.accept(false)
            }
            
            return Observable.empty()
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { (photos: [Photo]) in
                                
                self.output.photos.accept(self.nextLoadPage == 1 ? photos : self.output.photos.value.filter({ (photo) -> Bool in
                    !self.emptyPhotos.contains(photo)
                }) + photos)
                self.nextLoadPage += 1
                
                self.output.loadingMore.accept(false)
            }, onError: { (error) in
                
                self.output.photos.accept(self.output.photos.value.filter({ (photo) -> Bool in
                    !self.emptyPhotos.contains(photo)
                }))
                
                self.output.loadingMore.accept(false)
            })
            .disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.nextLoadPage = 1

            // Before the request returns.
            self.output.photos.accept(self.emptyPhotos)
            
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
        
        // Search query.
        self.input.searchQuery
            .distinctUntilChanged()
            .filter({ $0 != "" })
            .subscribe { (_) in
                self.input.listOrderBy.accept("")
                self.input.topic.accept("")
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
        
        // Order by.
        self.input.listOrderBy
            .distinctUntilChanged()
            .filter({ $0 != "" })
            .subscribe { (_) in
                self.input.searchQuery.accept("")
                self.input.topic.accept("")
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
        
        // Topic.
        self.input.topic
            .distinctUntilChanged()
            .filter({ $0 != "" })
            .subscribe { (_) in
                self.input.searchQuery.accept("")
                self.input.listOrderBy.accept("")
                self.input.reloadAction?.execute()
            }
            .disposed(by: self.disposeBag)
    }
    
}
