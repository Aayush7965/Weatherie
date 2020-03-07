//
//  WeatherModel.swift
//  Weatherie
//
//  Created by Aayush Pareek on 04/03/20.
//  Copyright © 2020 Aayush Pareek. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}
//weather[0].id

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
