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
        var query: PublishSubject<String> = PublishSubject<String>()
        var loadMoreAction: Action<Void, [Photo]>?
        var reloadAction: Action<Void, Void>?
    }
    public var input:Input = Input()
    
    /// MARK: Output
    struct Output {
        var photos: BehaviorSubject<[Photo]> = BehaviorSubject<[Photo]>(value: [])
        var loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    }
    public var output: Output = Output()
    
    /// MARK: Private
    let currentPage: Int = 1
    
    /// MARK: Bind
    override func bind() {
        let photoService = self.service as! PhotoService
        
        self.output.photos = BehaviorSubject<[Photo]>(value: [Photo()])
        
        self.input.loadMoreAction = Action<Void, [Photo]>(workFactory: { (_) -> Observable<[Photo]> in
            return photoService.searchPhotos(query: "penguin", page: self.currentPage)
            // return Observable.empty()
        })
        
        self.input.loadMoreAction?.elements
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (photos: [Photo]) in
                if let value = try? self.output.photos.value(){
                    self.output.photos.onNext(value + photos)
                }
            }, onError: { (error) in
                // FIXME: cancel loading state.
            }).disposed(by: self.disposeBag)
        
        self.input.loadMoreAction?.execute()
    }
    
    
}
