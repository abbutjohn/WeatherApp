//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 25/08/2022.
//

import Foundation


protocol Endpoint {
    
    var scheme: String{ get }
    var base: String { get }
    var body : [String: Any] { get }
    var httpMethod: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
}

