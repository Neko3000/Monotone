//
//  TopicService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation

import ObjectMapper
import RxSwift

class TopicService: NetworkService{
    public func listTopics(ids: String? = "",
                           page: Int? = 1,
                           perPage: Int? = 10,
                           orderBy: String? = ""){
        
        
        
    }
    
    public func getTopicPhotos(idOrSlug: String,
                               page: Int? = 1,
                               perPage: Int? = 10,
                               orientation: String? = "",
                               orderBy: String? = "latest")  -> Observable<[Photo]>{
        
        let request = GetTopicPhotosRequest()
        request.idOrSlug = idOrSlug
        request.page = page
        request.perPage = perPage
        request.orientation = orientation
        request.orderBy = orderBy
                
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = GetTopicPhotosResponse(JSON: json)
                
                observer.onNext(response!.results!)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
