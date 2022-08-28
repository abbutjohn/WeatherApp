//
//  Router.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 23/08/2022.
//

import Foundation
import Combine

public protocol NetworkControllerProtocol: AnyObject {
    
    typealias Headers = [String: Any]
    
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers
    ) -> AnyPublisher<T, APIError> where T: Decodable
}

public final class Router: NetworkControllerProtocol {
    
    public init() {
        
    }
    
    public func get<T: Decodable>(type: T.Type,
                           url: URL,
                           headers: Headers
    ) -> AnyPublisher<T, APIError> {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
         
         let decoder = JSONDecoder()
         
         return URLSession.shared
             .dataTaskPublisher(for:urlRequest)
             .receive(on: DispatchQueue.main)
             .mapError { _ in .responseUnsuccessful }
             .flatMap { data, response -> AnyPublisher<T, APIError> in
                 if let response = response as? HTTPURLResponse {
                     if (200...299).contains(response.statusCode) {
                         
                         return Just(data)
                             .decode(type: T.self, decoder: decoder)
                             .mapError {_ in .jsonParsingFailure}
                             .eraseToAnyPublisher()
                         
                     } else {
                         
                         return Fail(error: .invalidData)
                             .eraseToAnyPublisher()
                     }
                 }
                 return Fail(error: .responseUnsuccessful)
                     .eraseToAnyPublisher()
             }
             .eraseToAnyPublisher()
    }
    
}

