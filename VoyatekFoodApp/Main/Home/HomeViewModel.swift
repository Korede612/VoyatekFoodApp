//
//  HomeViewModel.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation
import Combine

class HomeViewModel: NSObject {
    var foods: [FoodItem] = []
    @Published var filteredFoods: [FoodItem] = []
    @Published var categories: [FoodCategory] = []
    @Published var onError: String? = nil
    
    var selectedCategoryIndex: Int = 0
    
    var foodTitle: String = "All Food"
    
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
                filteredFoods = model.data
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
    
    func getFoodTitle() -> String {
        guard categories.count > selectedCategoryIndex else { return ""}
        return selectedCategoryIndex == 0 ? "All Foods" : categories[selectedCategoryIndex].name
    }
    
    func filterTableView(categoryIndex: Int) {
        selectedCategoryIndex = categoryIndex
        guard categories.count >= categoryIndex && categoryIndex != 0 else {
            filteredFoods = foods
            return
        }
        let categories = categories[categoryIndex - 1]
        filteredFoods = foods.filter({$0.category.id == categories.id})
    }
    
}
