//
//  WeatherMock.swift
//  WeatherAppTests
//
//  Created by Anumol Abraham Chakkungal on 26/08/2022.
//
import XCTest
import Combine
@testable import WeatherApp


class WeatherMock: OpenWeatherMapContainerProtocol {
    
    var result:  AnyPublisher<WeatherData, APIError>!

    func getWetherData(for lat : String, long: String) -> AnyPublisher<WeatherData, APIError>{
        
        return result
    }
}


