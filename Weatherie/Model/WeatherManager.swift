//
//  WeatherManager.swift
//  Weatherie
//
//  Created by Aayush Pareek on 04/03/20.
//  Copyright © 2020 Aayush Pareek. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather (weatherManager: WeatherManager, weatherData: WeatherModel)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=YOUR_API_KEY"
    
    
    func featchWeather(cityName: String) {
        let newCityName = cityName.replacingOccurrences(of: " ", with: "+")
        let url = "\(weatherUrl)&q=\(newCityName)"
        performRequest(urlString: url)
    }
    
    func featchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        //lat={lat}&lon={lon}
        let url = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print(e)
                } else {
                    if let safeData = data {
                        if let data = self.parseJSON(with: safeData) {
                            self.delegate?.didUpdateWeather(weatherManager: self, weatherData: data)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(with data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(cityName: name, conditionId: id, temperature: temp)
            return weather
        } catch {
            print(error)
        }
        return nil
    }
    
    
    
    
    
}


