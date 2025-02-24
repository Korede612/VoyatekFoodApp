//
//  FoodResponse.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation

struct FoodResponse: Codable {
    let status: String
    let message: String
    let data: [FoodItem]
}

struct FoodItem: Codable {
    let id: Int
    let name: String
    let description: String
    let categoryID: Int
    let calories: Int
    let createdAt: String
    let updatedAt: String
    let foodTags: [String]
    let foodImages: [FoodImage]
    let category: FoodCategory

    enum CodingKeys: String, CodingKey {
        case id, name, description, calories, foodTags, foodImages, category
        case categoryID = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct FoodImage: Codable {
    let id: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
    }
}

struct FoodCategory: Codable, FoodCategoryInterface {
    let id: Int
    let name: String
    let description: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

protocol FoodCategoryInterface {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var createdAt: String { get }
    var updatedAt: String { get }
}
