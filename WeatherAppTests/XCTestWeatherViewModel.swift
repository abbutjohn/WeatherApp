//
//  XCTestWeatherViewModel.swift
//  WeatherAppTests
//
//  Created by Anumol Abraham Chakkungal on 26/08/2022.
//

import XCTest
import Combine
@testable import WeatherApp


class XCTestWeatherViewModel: XCTestCase {
    
    private var mockClient: WeatherMock!
    private var viewModelToTest: WeatherViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        
        mockClient = WeatherMock()
        viewModelToTest = WeatherViewModel(openWetherMapController: mockClient)
    }

    override func tearDownWithError() throws {
        
        mockClient = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }
    
    
    func testGetWeatherDataEmpty() {
        
        let weatherData: WeatherData = WeatherData(weather: [], main: WeatherData.ClimateObj(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0.0, humidity: 0.0), name: "Weather", wind: WeatherData.windObj(speed: 0.0, deg: 0.0), message: "")
        
        let expectation = XCTestExpectation(description: "waiting for weatherData")
        
        viewModelToTest.$weatherData.sink { state in
            
            XCTAssertEqual(state.count, 0)
            expectation.fulfill()
            
        }.store(in: &cancellables)
        
        
        mockClient.result = Result.success(weatherData).publisher.eraseToAnyPublisher()
        viewModelToTest.getData(lat: "", long: "")
        
        wait(for: [expectation], timeout: 5)
    }
    

}
