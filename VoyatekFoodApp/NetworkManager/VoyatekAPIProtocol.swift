//
//  VoyatekAPIProtocol.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Combine

protocol VoyatekFoodAPIProtocol {
    func fetchFoodData() -> Future<FoodResponse, Error>
}

protocol VoyatekFoodCategoryAPIProtocol {
    func fetchFoodCategoryData() -> Future<CategoriesResponse, Error>
}

protocol VoyaatekTagAPIProtocol {
    func fetchFoodTagsData() -> Future<TagResponse, Error>
}
