//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 25/08/2022.
//

import Foundation


struct WeatherData: Decodable {
    
    var weather: [WeatherObj]?
    var main: ClimateObj?
    var name: String?
    var wind: windObj?
    var message : String?


    struct WeatherObj: Decodable {
        
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct ClimateObj: Decodable {
        
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct windObj: Decodable {
        var speed: Double
        var deg: Double
    }
}

