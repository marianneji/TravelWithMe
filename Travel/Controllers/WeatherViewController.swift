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
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

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
        
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.cityName
            self.weatherConditionImageView.image = UIImage(named: weather.conditionName)

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
            if success, let weather = weather {
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
                if success, let weather = weather {
                    self.didUpdateWeather(self.weatherManager, weather: weather)
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
}

