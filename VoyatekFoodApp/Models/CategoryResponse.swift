//
//  CategoryResponse.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation

struct CategoriesResponse: Codable {
    let status: String
    let message: String
    let data: [FoodCategory]
}
