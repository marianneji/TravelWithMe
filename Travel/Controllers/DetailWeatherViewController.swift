//
//  DetailWeatherViewController.swift
//  Travel
//
//  Created by Graphic Influence on 10/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController, WeatherManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var allStackView: UIStackView!

    var selectedCity: WeatherModel?

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {

        conditionImageView.image = UIImage(named: weather.conditionName)
        descriptionLabel.text = weather.description
        tempLabel.text = "Temperature: \(weather.doubleToString(value: weather.temperature))°C"
        tempMinLabel.text = "Minimum: \(weather.doubleToString(value: weather.tempMin))°C"
        tempMaxLabel.text = "Maximum: \(weather.doubleToString(value: weather.tempMax))°C"
        windLabel.text = "Wind Speed: \(weather.windSpeed) Km/h"
        humidityLabel.text = "Humidity: \(weather.humidity)"
        sunriseLabel.text = "Sunrise: \(weather.sunrise.getDateStringFromUTC())"
        sunsetLabel.text = "Sunset: \(weather.sunset.getDateStringFromUTC())"

    }

    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {

    }

    func didFailWithError(message: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = selectedCity else { return }
        didUpdateWeather(WeatherManager.shared, weather: city)
        self.title = "\(city.cityName)"
    }
}
