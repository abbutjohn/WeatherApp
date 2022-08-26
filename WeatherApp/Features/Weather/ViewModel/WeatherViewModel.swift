//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 25/08/2022.
//


import Foundation
import Combine


final class WeatherViewModel: ObservableObject {
    
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    
    // MARK:- Publishers
    @Published var description          : String                =   ""
    @Published var placeName            : String                =   ""
    @Published var minTemprature        : String                =   ""
    @Published var maxTemprature        : String                =   ""
    @Published var currentTemprature    : String                =   ""
    @Published var feelsLikeTeprature   : String                =   ""
    @Published var humidity             : String                =   ""
    @Published var searchCity           : String                =   ""
    @Published var wind                 : String                =   ""
    @Published var isLoading            : Bool                  =   false
    @Published var weatherData          : [WeatherData]         =   []
   
    var weatherMapController : OpenWetherMapContainerProtocol
    
    init(openWetherMapController : OpenWetherMapContainerProtocol = OpenWetherMapContainer()) {
      
        weatherMapController = openWetherMapController
    }
        
    func getData(lat : String, long: String)  {
        
        isLoading = true
        
        cancellable = weatherMapController.getWetherData(for: lat, long: long)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            },
            receiveValue: {[weak self] result in
                
                if result.message != nil{
                    
                     print("Handle error")
                }
                else{
                    self?.description            =      String(format: "%@", result.weather?.first?.main ?? "" )
                    self?.placeName              =      result.name ?? ""
                    self?.minTemprature          =      String(format: "%.2f", result.main?.temp_min ?? 0.0 )
                    self?.maxTemprature          =      String(format: "%.2f", result.main?.temp_max ?? 0.0)
                    self?.currentTemprature      =      String(format: "%.2f", result.main?.temp ?? 0.0)
                    self?.feelsLikeTeprature     =      String(format: "%.2f", result.main?.feels_like ?? 0.0)
                    self?.humidity               =      String(format: "%.2f", result.main?.humidity ?? 0.0)
                    self?.wind                   =      String(format: "%.2f", result.wind?.speed ?? 0.0)
                    self?.weatherData[0]         =      result
                }
                
                self?.isLoading = false
            })
    }
    
    deinit{
        
        cancellable?.cancel()
    }
}


