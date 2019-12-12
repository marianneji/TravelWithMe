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
        addNewYorkCityAndCurrentLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("\(weatherList.count) nombre d'élément dans weather list")
        return weatherList.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailWeatherViewController else { return }

        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destinationVC.selectedCity = weatherList[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailWeather", sender: weatherList[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        let city = weatherList[indexPath.row]
        cell.cityLabel.text = city.cityName
        cell.tempLabel.text = city.tempString
        cell.conditionImageView.image = UIImage(named: "\(city.conditionName)")

        return cell
    }

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

                        print("\(self.weatherList.count)... dans la fermeture")
                    } else {
                        let ac = UIAlertController(title: "Error", message: "impossible d'avoir les données du serveur", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(ac, animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    fileprivate func addNewYorkCityAndCurrentLocation() {
        DispatchQueue.main.async {
            WeatherManager.shared.getCity(city: "new%20york") { (success, weather) in
                if success, let weather = weather {
                    self.weatherList.append(weather)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension WeatherTableViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            DispatchQueue.main.async {
                WeatherManager.shared.getCurrentLocationW(latitude: lat, longitude: lon) { (success, weather) in
                    if success, let weather = weather { self.weatherList.append(weather)
                        self.tableView.reloadData()
                    } else {

                        print("il y a un problème de current location")
                    }
                }
            }

            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}

//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        let cell = WeatherTableViewCell()
//        cell.cityLabel.text = weather.cityName
//        cell.tempLabel.text = "\(weather.doubleToString(value: weather.temperature))°C"
//        cell.conditionImageView.image = UIImage(named: "\(weather.conditionName)")
//        DispatchQueue.main.async {
//
//            self.weatherList.append(weather)
//        }
//
//
//
//
//    }
//
//    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {
//
//    }
//
//    func didFailWithError(message: String) {
//        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(ac, animated: true)
//    }
//
//
//}
