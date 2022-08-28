//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 26/08/2022.
//


import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            
            
            VStack(spacing: 20) {
                Text("Welcome to the Weather App")
                    .bold()
                    .font(.title)
                
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
        
            Button {
                
                locationManager.requestAlertForLocation()
                
            } label: {
                
                HStack{
                    
                    Image(systemName: "location.circle")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Share my Location")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.all, 8)
                .background(.blue)
                .cornerRadius(20.0)
            }
            .padding()
  
    
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
