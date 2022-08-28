//
//  NetworkServiceRouter.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 25/08/2022.
//

import Foundation


private enum API{
    
    static let key = "8cd3f6c99d70b1d5cae276e4a3927d67"
}


extension ApiFeeds: Endpoint {
    
    var scheme: String{
        return "https"
    }
    
    var base: String {
        return  AppBaseUrl.stage
    }
    
    var path: String {
        
        switch self {
        
        case .getWeatherData(_,_):
            return "/data/2.5/weather"

        }
    }
    
    var httpMethod: String {
        
        switch self {
        case .getWeatherData(_,_):
            return "GET"
        }
    }
    
    var body: [String: Any]  {
        
        switch self {
        case .getWeatherData(_,_):
            return [:]
        }
    }
    
    
    var parameters: [URLQueryItem]{
        
        switch self {
        case .getWeatherData(let lat, let long):
            return  [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: long),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: API.key),
            ]
            
        }
    }
    
}
extension ApiFeeds {
  
    
     public var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = AppBaseUrl.stage
        components.path = path
        components.queryItems = parameters
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components")
        }
        
        return url
    }
}
