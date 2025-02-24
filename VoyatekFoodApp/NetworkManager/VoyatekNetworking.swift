//
//  VoyatekNetworking.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation

enum VoyatekNetworking {
    case fetchCategories
    case getTags
    case fetchFood
}

extension VoyatekNetworking: TargetType {
    
    var path: String {
        switch self {
        case .fetchCategories:
            return "categories"
        case .getTags:
            return "tags"
        case .fetchFood:
            return "foods"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCategories, .getTags, .fetchFood:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchCategories, .getTags, .fetchFood:
            return .getRequest
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "https://assessment.vgtechdemo.com/api/"
        }
    }
    
    var request: URLRequest? {
        switch self {
        default:
            guard let url = URL(string: baseURL + path)
            else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
        
    }
}
