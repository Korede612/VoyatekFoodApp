//
//  TagResponse.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation

struct TagResponse: Decodable {
    let status: String
    let message: String
    let data: [Tag]
}

struct Tag: Decodable {
    let id: Int
    let name: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
