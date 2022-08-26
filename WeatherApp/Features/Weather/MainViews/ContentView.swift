//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anumol Abraham Chakkungal on 26/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            
            if let _ = locationManager.location {
                
                WeatherView()
                    .environmentObject(locationManager)
                
            } else {
                
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color.cyan)
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


