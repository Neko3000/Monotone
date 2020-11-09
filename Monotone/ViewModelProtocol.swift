//
//  ViewModelProtocol.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift
import Action

protocol ViewModelIOProtocol {
    associatedtype Input
    associatedtype Output
    
    var input:Input { get }
    var output:Output { get }
}

protocol ViewModelBindProtocol {
    func bind()
}

class ViewModel: ViewModelBindProtocol{
    var service: NetworkService?
    let disposeBag: DisposeBag = DisposeBag()
    
    init(service: NetworkService) {
        self.service = service
        self.bind()
    }
    
    internal func bind() {
        // Implementated by subclass.
    }
}

class SearchPhotosViewModel: ViewModel, ViewModelIOProtocol{
    
    /// MARK: Input
    struct Input {
        var query: BehaviorSubject<String> = BehaviorSubject<String>(value:"")
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, [Photo]>?
    }
    public var input:Input = Input()
    
    /// MARK: Output
    struct Output {
        var photos: BehaviorSubject<[Photo]> = BehaviorSubject<[Photo]>(value: [])
        var loadingMore: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
        var reloading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    }
    public var output: Output = Output()
    
    /// MARK: Private
    private var currentPage: Int = 1
    
    /// MARK: Bind
    override func bind() {
        // Specify Service.
        let photoService = self.service as! PhotoService
                
        // LoadMore.
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.output.loadingMore.onNext(true)
            
            guard  let query = try? self.input.query.value() else { return .empty() }
            return photoService.searchPhotos(query: query , page: self.currentPage + 1)
        })
        
        self.input.loadMoreAction?.elements
            .subscribe(onNext: { (photos: [Photo]) in
                if let value = try? self.output.photos.value(){
                    self.output.photos.onNext(value + photos)
                    self.currentPage += 1
                }
                
                self.output.loadingMore.onNext(false)
            }, onError: { (error) in
                self.output.loadingMore.onNext(false)
            }).disposed(by: self.disposeBag)
        
        // Reload.
        self.input.reloadAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            self.output.reloading.onNext(true)
            
            guard  let query = try? self.input.query.value() else { return .empty() }
            return photoService.searchPhotos(query: query , page: 1)
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
