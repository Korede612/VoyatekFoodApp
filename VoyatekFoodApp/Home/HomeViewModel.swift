//
//  HomeViewModel.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation
import Combine

class HomeViewModel: NSObject {
    @Published var foods: [FoodItem] = []
    @Published var categories: [FoodCategory] = []
    @Published var onError: String? = nil
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    var service: HomeFoodServiceInterface = FoodServices()
    
    func fetchFood() {
        service.fetchFoodData()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] model in
                guard let self else { return }
                foods = model.data
            }
            .store(in: &subscriptions)
    }
    
    func fetchFoodCategories() {
        service.fetchFoodCategoryData()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] model in
                guard let self else { return }
                categories = model.data
            }
            .store(in: &subscriptions)
    }
    
}
