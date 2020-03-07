//
//  ViewController.swift
//  Weatherie
//
//  Created by Aayush Pareek on 04/03/20.
//  Copyright © 2020 Aayush Pareek. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // User gets a popup that he wants to give his location data to our app
        
        // Then we have to go to info.plist and add Privacy - Location When In Use Usage Description
        
        locationManager.requestLocation() // This method request for a one time delevery of location
        //locationManager.startUpdatingLocation() // This monitors users step by step location ex. fitness app, gps app
        
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
}

//MARK:- UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
           searchTextField.endEditing(true)
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text == "" {
            searchTextField.placeholder = "Type Location"
            return false
        } else {
            searchTextField.endEditing(true)
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            // We have the city Name
            weatherManager.featchWeather(cityName: cityName)
            
            
        }
        searchTextField.text = ""
    }
    
}

//MARK:- WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(weatherManager: WeatherManager, weatherData: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weatherData.temperatureString
            self.cityLabel.text = weatherData.cityName
            self.conditionImageView.image = UIImage(systemName: weatherData.conditionName)
        }
    }
}

//MARK:- CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last { // last location is most accurate
            locationManager.stopUpdatingLocation() // Stop updating location so if we request a location it will run again
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherManager.featchWeather(lat: latitude, lon: longitude)
        }
    }
    
    // Important to implement didFailWithError if not our app will crash
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
