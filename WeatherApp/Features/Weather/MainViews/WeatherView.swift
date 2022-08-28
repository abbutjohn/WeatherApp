//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 23/08/2022.
//

import SwiftUI

struct WeatherView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel : WeatherViewModel = WeatherViewModel()
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            VStack {
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text($viewModel.placeName.wrappedValue)
                            .bold()
                            .font(.title)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        
                        Button {
                            
                            //Update Location
                            locationManager.requestLocation()
                            
                        } label: {
                            Image(systemName: "arrow.clockwise.circle")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
               
                
                Spacer()
                
                VStack {
                    HStack {
                        
                        VStack(spacing: 20) {
                            
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(viewModel.description)")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding()
                        }
                        .frame(alignment: .leading)
                        
                        Spacer()
                        
                        Text(viewModel.currentTemprature + "°")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: ($viewModel.minTemprature.wrappedValue + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: ($viewModel.maxTemprature.wrappedValue + ("°")))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value:
                                    ($viewModel.wind.wrappedValue + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: $viewModel.humidity.wrappedValue + "%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20)
            }
            
            if $viewModel.isLoading.wrappedValue{
                
                LoadingView()
            }
        }
        .onAppear(perform: {
            
            performFetch()
        })
        .onReceive(locationManager.$isLoading, perform: { value in
            
            if !value {
                
                performFetch()
            }
            
        })
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.cyan)
        .preferredColorScheme(.dark)
    }
    
    func performFetch() {
        
        if let location = $locationManager.location.wrappedValue{
            
            viewModel.getData(lat: "\(location.latitude)", long: "\( location.longitude)")
            
        }
    }

}



struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
