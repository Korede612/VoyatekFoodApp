//
//  FoodServices.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation
import Combine

class GeneralNetworkService: VoyatekAPI<VoyatekNetworking> {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func generalFetch<M: Decodable>(target: VoyatekNetworking, responseClass: M.Type) -> Future<M, Error> {
        return Future<M, Error> {[weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            self.fetchData(target: target, responseClass: M.self)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print("Completion: \(completion)")
                } receiveValue: { result in
                    promise(.success(result))
                }
                .store(in: &self.subscriptions)
        }
    }
}

protocol HomeFoodServiceInterface: VoyatekFoodAPIProtocol, VoyatekFoodCategoryAPIProtocol { }

class FoodServices: GeneralNetworkService, HomeFoodServiceInterface {
    
    func fetchFoodData() -> Future<FoodResponse, Error> {
        return generalFetch(target: .fetchFood, responseClass: FoodResponse.self)
//        return Future<FoodResponse, Error> {[weak self] promise in
//            guard let self = self else { return promise(.failure(NetworkError.unknown))}
//            self.fetchData(target: .fetchFood, responseClass: FoodResponse.self)
//                .receive(on: RunLoop.main)
//                .sink { completion in
//                    print("Completion: \(completion)")
//                } receiveValue: { result in
//                    promise(.success(result))
//                }
//                .store(in: &self.subscriptions)
//        }
    }
    
//    func generalFetch(_ type: VoyatekNetworking, responseObject: Decodable) -> Future<Decodable, Error> {
    
    
}

extension FoodServices {
    func fetchFoodCategoryData() -> Future<CategoriesResponse, Error> {
        return generalFetch(target: .fetchCategories, responseClass: CategoriesResponse.self)
//        return Future<CategoriesResponse, Error> {[weak self] promise in
//            guard let self = self else { return promise(.failure(NetworkError.unknown))}
//            self.fetchData(target: .fetchCategories, responseClass: CategoriesResponse.self)
//                .receive(on: RunLoop.main)
//                .sink { completion in
//                    print("Completion: \(completion)")
//                } receiveValue: { result in
//                    promise(.success(result))
//                }
//                .store(in: &self.subscriptions)
//        }
    }
}

extension FoodServices: VoyaatekTagAPIProtocol {
    func fetchFoodTagsData() -> Future<TagResponse, Error> {
        return generalFetch(target: .getTags, responseClass: TagResponse.self)
//        return Future<TagResponse, Error> {[weak self] promise in
//            guard let self = self else { return promise(.failure(NetworkError.unknown))}
//            self.fetchData(target: .fetchCategories, responseClass: TagResponse.self)
//                .receive(on: RunLoop.main)
//                .sink { completion in
//                    print("Completion: \(completion)")
//                } receiveValue: { result in
//                    promise(.success(result))
//                }
//                .store(in: &self.subscriptions)
//        }
    }
}
