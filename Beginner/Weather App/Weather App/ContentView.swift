//
//  ContentView.swift
//  Weather App
//
//  Created by Gergő on 08/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: isNight ? .black : .blue,
                           bottomColor: isNight ? .gray : Color("lightblue"))
            VStack {
                CityTextView(cityName: "Budapest")
                
                MainWeatherView(imageName: isNight ? "cloud.moon.fill" : "cloud.sun.fill",
                                temperature: 23)
                Spacer()
                HStack(spacing: 25) {
                    WeatherDayView(dayOfWeek: "TUE",
                                   imageName: isNight ? "cloud.moon.fill" : "cloud.sun.fill",
                                   temperature: 24)
                    
                    WeatherDayView(dayOfWeek: "WED",
                                   imageName: isNight ? "moon.fill" : "sun.max.fill",
                                   temperature: 27)
                    
                    WeatherDayView(dayOfWeek: "THU",
                                   imageName: "cloud.rain.fill",
                                   temperature: 18)
                    
                    WeatherDayView(dayOfWeek: "FRI",
                                   imageName: "cloud.heavyrain.fill",
                                   temperature: 17)
                    
                    WeatherDayView(dayOfWeek: "SAT",
                                   imageName: "cloud.fill",
                                   temperature: 21)
                }
                Spacer()
                Button(action: {
                    isNight.toggle()
                }, label: {
                    Text("Change Day Time")
                        .frame(width: 280, height: 50)
                        .background(.white)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10.0)
                })
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16,
                              weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28,
                              weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct MainWeatherView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70,
                              weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 36,
                          weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}

struct BackgroundView: View {
    
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(colors: [topColor, bottomColor],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}
