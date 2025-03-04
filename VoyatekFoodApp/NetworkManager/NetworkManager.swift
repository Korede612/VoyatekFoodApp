//
//  NetworkManager.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET" // Other requests can be added here
    case post = "POST"
}

enum Task {
    case getRequest // Various tasks like (POST, DELETE) can be added here also
}

protocol TargetType {
    var baseURL: String { get } // This holds the base URL
    var path: String { get } // This adds to the base url for a particular endpoint
    var method: HTTPMethod { get } // This handles all the HTTP methods that where added, although the only method here is the GET others are: POST, DELETE, PATCH and so on.
    var task: Task { get } // This is for the type of action depending on the method
    
    var request: URLRequest? { get }
}

class VoyatekAPI<T: TargetType> {
    
    private var cancellabes = Set<AnyCancellable>()
    
    private func buildParams(task: Task) -> Data {
        switch task {
        case .getRequest:
            do {
                return try JSONSerialization.data(withJSONObject: [:], options: [])
            } catch {
                print("An error has occured")
            }
        }
        return Data()
    }
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type) -> Future<M, Error> {
        return Future<M, Error> { [weak self] promise in
            guard let request = target.request,
                  let self
            else { return promise(.failure(NetworkError.invalidURL)) }
            URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap(self.handleData)
                .decode(type: M.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        print("Finished")
                    }
                } receiveValue: { decodedData in
                    promise(.success(decodedData))
                }
                .store(in: &self.cancellabes)
        }
    }
    
    func handleData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse,
              httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
        else {
            throw NetworkError.responseError
        }
        return output.data
    }
}
