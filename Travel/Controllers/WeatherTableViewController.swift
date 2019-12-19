//
//  WeatherTableViewController.swift
//  Travel
//
//  Created by Graphic Influence on 10/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController {

    var weatherList = [WeatherModel]()
    var weatherManager = WeatherManager.shared
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSeveralCities()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        tableView.reloadData()
    }

    // MARK: - TableView Delegate and DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(weatherList.count) nombre d'élément dans weather list")
        return weatherList.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailWeather", sender: weatherList[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        let city = weatherList[indexPath.row]
        cell.cityLabel.text = city.cityName
        cell.tempLabel.text = "\(city.temperature.doubleToStringOneDecimal())°C"
        cell.conditionImageView.image = UIImage(named: "\(city.conditionName)")
        cell.setupCell()
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
//MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailWeatherViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destinationVC.selectedCity = weatherList[indexPath.row]
    }
//MARK: - Actions
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new city", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let textFieldText = textField.text else { return }
            DispatchQueue.main.async {
                WeatherManager.shared.getCity(city: textFieldText) { (success, weather) in
                    if success, let weather = weather {
                        self.weatherList.append(weather)
                        self.tableView.reloadData()

                    } else {
                        self.didFailWithError(message: "Unable to reach the server. Check your internet connection")
                    }
                }
            }

        }))
        alert.addTextField { (actionTextField) in
            actionTextField.placeholder = "Type a city name"
            textField = actionTextField
        }
        present(alert, animated: true)
    }

        @IBAction func refreshPressed(_ sender: UIBarButtonItem) {
            weatherList.removeAll()
            addSeveralCities()
            locationManager.requestLocation()
            tableView.reloadData()
        }
    
    fileprivate func addSeveralCities() {
        let message = "Not possible to get the server. Check your internet connection and refresh"

        WeatherManager.shared.getCity(city: "paris") { (success, weather) in
            DispatchQueue.main.async {
                if success, let paris = weather {
                    self.weatherList.append(paris)

                } else {
                    self.didFailWithError(message: message)
                }
            }
        }
        WeatherManager.shared.getCity(city: "new%20york") { (success, weather) in
            DispatchQueue.main.async {
                if success, let newyork = weather {
                    self.weatherList.append(newyork)
                } else {
                    self.didFailWithError(message: message)
                }
            }
        }
    }
}
//MARK: - LocationManagerDelegate
extension WeatherTableViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            DispatchQueue.main.async {
                WeatherManager.shared.getCurrentLocationWeather(latitude: lat, longitude: lon) { (success, weather) in
                    if success, let weather = weather { self.weatherList.append(weather)
                        self.tableView.reloadData()
                    } else {
                        self.didFailWithError(message: "Not possible to get your current location")
                    }
                }
            }
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError(message: "Not possible to get your current location")
    }
}
