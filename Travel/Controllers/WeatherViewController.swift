//
//  ViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!


    @IBOutlet weak var allUIStackView: UIStackView!
    //MARK: - CurrentLocationOutlets
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentWeatherConditionView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentTempMinLabel: UILabel!
    @IBOutlet weak var currentTempMaxLabel: UILabel!
    @IBOutlet weak var currentWindLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentWeatherDescLabel: UILabel!

    //MARK: - Properties
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager.shared

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
        locationManager.delegate = self
        WeatherManager.shared.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        loadWeatherForNY()
    }

    func loadWeatherForNY() {
        WeatherManager.shared.getCity(city: "new%20york") { (success, weather) in
            self.toggleActivityIndicator(shown: true)
            if success, let weather = weather {
                self.toggleActivityIndicator(shown: false)
                self.didUpdateWeather(self.weatherManager, weather: weather)
            } else {
                self.didFailWithError(message: "We couldn't get the weather from NYC")
            }
        }
    }


    //MARK: - Actions
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        cityTextField.resignFirstResponder()
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        self.temperatureLabel.text = "\(weather.tempString)°C"
        self.cityLabel.text = weather.cityName
        self.weatherConditionImageView.image = UIImage(named: weather.conditionName)
        self.tempMinLabel.text = "Min: \(weather.doubleToString(value: weather.tempMin))°C"
        self.tempMaxLabel.text = "Max: \(weather.doubleToString(value: weather.tempMax))°C"
        self.windLabel.text = "Wind: \(weather.windSpeed)km/h"
        self.humidityLabel.text = "Humidity: \(weather.humidity)%"
        self.weatherDescriptionLabel.text = "\(weather.description)"

    }
    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {
        self.currentCityLabel.text = currentWeather.currentCity
        self.currentTempLabel.text = "\(currentWeather.tempString)°C"
        self.currentWeatherConditionView.image = UIImage(named: currentWeather.conditionName)
        self.currentTempMinLabel.text = "Min: \(currentWeather.doubleToString( currentWeather.currentTempMin))°C"
        self.currentTempMaxLabel.text = "Max: \(currentWeather.doubleToString( currentWeather.currentTempMax))°C"
        self.currentWindLabel.text = "Wind: \(currentWeather.currentWindSpeed)km/h"
        self.currentHumidityLabel.text = "Humidity: \(currentWeather.currentHumidity)%"
        self.currentWeatherDescLabel.text = "\(currentWeather.currentDescription)"
    }

    func didFailWithError(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true)

    }
}

//MARK: - TextFieldManager
extension WeatherViewController: UITextFieldDelegate  {
    func textFieldDidEndEditing(_ textField: UITextField) {
        WeatherManager.shared.getCity(city: cityTextField.text!) { (success, weather) in
            self.toggleActivityIndicator(shown: true)
            if success, let weather = weather {
                self.toggleActivityIndicator(shown: false)
                self.didUpdateWeather(self.weatherManager, weather: weather)
            } else {
                self.didFailWithError(message: "We didn't find the city you're looking for")
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type a City name here"
            return false
        }
    }
}
//MARK: - LocationManager
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            WeatherManager.shared.getCurrentLocationWeather(latitude: lat, longitude: lon) { (success, weather) in
                self.toggleActivityIndicator(shown: true)
                if success, let weather = weather {
                    self.toggleActivityIndicator(shown: false)
                    self.didUpdateCurrentWeather(self.weatherManager, currentWeather: weather)
                } else {
                    self.didFailWithError(message: "We didn't get your current location")
                }
            }
            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError(message: "We didn't get your location")
    }
    fileprivate func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        allUIStackView.isHidden = shown
    }
}

