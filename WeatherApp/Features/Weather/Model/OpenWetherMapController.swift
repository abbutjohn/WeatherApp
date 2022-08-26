//
//  OpenWetherMapContainer.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 23/08/2022.
//

import Foundation
import Combine

protocol OpenWetherMapContainerProtocol: AnyObject {
    
    func getWetherData(for lat : String, long: String) -> AnyPublisher<WeatherData, APIError>
   
}

final class OpenWetherMapContainer: OpenWetherMapContainerProtocol {
  
    
    let networkController: NetworkControllerProtocol
    
    init() {
        self.networkController = Router()
    }
    
    func getWetherData(for lat : String, long: String) -> AnyPublisher<WeatherData, APIError>{
        
        let endpoint = ApiFeeds.getWeatherData(lat: lat, long: long)
        return networkController.get(type: WeatherData.self,
                                     url: endpoint.url,
                                           headers: [:])
    }
 
}
