//
//  WeatherData.swift
//  Weatherie
//
//  Created by Aayush Pareek on 04/03/20.
//  Copyright © 2020 Aayush Pareek. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionId: Int
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }

    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.max.fill"
        }
    }
}
