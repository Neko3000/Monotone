//
//  UserService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import ObjectMapper
import RxSwift

class UserService: NetworkService {
    
    public func getMineProfile() -> Observable<User>{
        let request: GetMineProfileRequest = GetMineProfileRequest()
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = GetMineProfileResponse(JSON: json)
                let user = response!.user!
                
                observer.onNext(user)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func listUserPhotos(username:String,
                               page:Int? = 1,
                               perPage:Int? = 10,
                               orderBy:String? = "latest",
                               stats:Bool? = false,
                               resolution:String? = "days",
                               quantity:Int? = 30,
                               orientation:String? = nil) -> Observable<[Photo]>{
        let request: ListUserPhotosRequest = ListUserPhotosRequest()
        request.username = username
        request.page = page
        request.perPage = perPage
        request.orderBy = orderBy
        request.stats = stats
        request.resolution = resolution
        request.quantity = quantity
        request.orientation = orientation
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = ListUserPhotosResponse(JSON: json)
                let photos = response!.results!
                
                observer.onNext(photos)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

    public func listUserCollections(username:String,
                                    page:Int? = 1,
                                    perPage:Int? = 10) -> Observable<[Collection]>{
        let request: ListUserCollectionsRequest = ListUserCollectionsRequest()
        request.username = username
        request.page = page
        request.perPage = perPage
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = ListUserCollectionsResponse(JSON: json)
                let collections = response!.results!
                
                observer.onNext(collections)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func listUserLikedPhotos(username:String,
                                    page:Int? = 1,
                                    perPage:Int? = 10,
                                    orderBy:String? = nil,
                                    orientation:String? = nil) -> Observable<[Photo]>{
        let request: ListUserLikedPhotosRequest = ListUserLikedPhotosRequest()
        request.username = username
        request.page = page
        request.perPage = perPage
        request.orderBy = orderBy
        request.orientation = orientation
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = ListUserLikedPhotosResponse(JSON: json)
                let photos = response!.results!
                
                observer.onNext(photos)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    public func statisticizeUser(username: String,
                                 resolution: String? = "days",
                                 quantity: Int? = 30) -> Observable<Statistics>{
        
        let request: StatisticizeUserRequest = StatisticizeUserRequest()
        request.username = username
        request.resolution = resolution
        request.quantity = quantity
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = StatisticizeUserResponse(JSON: json)
                let statistics = response!.statistics!
                
                observer.onNext(statistics)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

}
