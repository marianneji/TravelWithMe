//
//  ViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

//import UIKit
//import CoreLocation
//
//class WeatherViewController: UIViewController {
//
//    //MARK: - Outlets
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//    @IBOutlet weak var cityTextField: UITextField!
//    @IBOutlet weak var weatherConditionImageView: UIImageView!
//    @IBOutlet weak var temperatureLabel: UILabel!
//    @IBOutlet weak var cityLabel: UILabel!
//    @IBOutlet weak var tempMinLabel: UILabel!
//    @IBOutlet weak var tempMaxLabel: UILabel!
//    @IBOutlet weak var windLabel: UILabel!
//    @IBOutlet weak var humidityLabel: UILabel!
//    @IBOutlet weak var weatherDescriptionLabel: UILabel!
//
//
//    @IBOutlet weak var allUIStackView: UIStackView!
//    //MARK: - CurrentLocationOutlets
//    @IBOutlet weak var currentCityLabel: UILabel!
//    @IBOutlet weak var currentWeatherConditionView: UIImageView!
//    @IBOutlet weak var currentTempLabel: UILabel!
//    @IBOutlet weak var currentTempMinLabel: UILabel!
//    @IBOutlet weak var currentTempMaxLabel: UILabel!
//    @IBOutlet weak var currentWindLabel: UILabel!
//    @IBOutlet weak var currentHumidityLabel: UILabel!
//    @IBOutlet weak var currentWeatherDescLabel: UILabel!
//
//    //MARK: - Properties
//    let locationManager = CLLocationManager()
//    var weatherManager = WeatherManager.shared
//
//    //MARK: - ViewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        cityTextField.delegate = self
//        locationManager.delegate = self
//        WeatherManager.shared.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//        loadWeatherForNY()
//    }
//
//    func loadWeatherForNY() {
//        WeatherManager.shared.getCity(city: "new%20york") { (success, weather) in
//            self.toggleActivityIndicator(shown: true)
//            if success, let weather = weather {
//                self.toggleActivityIndicator(shown: false)
//                self.didUpdateWeather(self.weatherManager, weather: weather)
//            } else {
//                self.didFailWithError(message: "We couldn't get the weather from NYC")
//            }
//        }
//    }
//
//
//    //MARK: - Actions
//    @IBAction func currentLocationPressed(_ sender: UIButton) {
//        locationManager.requestLocation()
//    }
//
//    @IBAction func searchPressed(_ sender: UIButton) {
//        cityTextField.resignFirstResponder()
//    }
//}
//
////MARK: - WeatherManagerDelegate
//extension WeatherViewController: WeatherManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        
//        self.temperatureLabel.text = "\(weather.temperature.doubleToStringOneDecimal())°C"
//        self.cityLabel.text = weather.cityName
//        self.weatherConditionImageView.image = UIImage(named: weather.conditionName)
////        guard let tempMin = weather.tempMin else {
////            return
////        }
////        guard let tempMax = weather.tempMax else {
////            return
////        }
////        guard let humidity = weather.humidity else {
////            return
////        }
////        guard let windSpeed = weather.windSpeed else {
////            return
////        }
////        guard let description = weather.description else {
////            return
////        }
//
//        self.tempMinLabel.text = "Min: \(weather.doubleToString(value: weather.tempMin))°C"
//        self.tempMaxLabel.text = "Max: \(weather.doubleToString(value: weather.tempMax))°C"
//        self.windLabel.text = "Wind: \(weather.windSpeed))km/h"
//        self.humidityLabel.text = "Humidity: \(weather.humidity))%"
//        self.weatherDescriptionLabel.text = "\(description)"
//
//    }
//    func didUpdateCurrentWeather(_ weatherManager: WeatherManager, currentWeather: CurrentWeatherModel) {
//        self.currentCityLabel.text = currentWeather.currentCity
//        self.currentTempLabel.text = "\(currentWeather.tempString)°C"
//        self.currentWeatherConditionView.image = UIImage(named: currentWeather.conditionName)
//        self.currentTempMinLabel.text = "Min: \(currentWeather.doubleToString( currentWeather.currentTempMin))°C"
//        self.currentTempMaxLabel.text = "Max: \(currentWeather.doubleToString( currentWeather.currentTempMax))°C"
//        self.currentWindLabel.text = "Wind: \(currentWeather.currentWindSpeed)km/h"
//        self.currentHumidityLabel.text = "Humidity: \(currentWeather.currentHumidity)%"
//        self.currentWeatherDescLabel.text = "\(currentWeather.currentDescription)"
//    }
//
//    func didFailWithError(message: String) {
//        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(ac, animated: true)
//
//    }
//}
//
////MARK: - TextFieldManager
//extension WeatherViewController: UITextFieldDelegate  {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        WeatherManager.shared.getCity(city: cityTextField.text!) { (success, weather) in
//            self.toggleActivityIndicator(shown: true)
//            if success, let weather = weather {
//                self.toggleActivityIndicator(shown: false)
//                self.didUpdateWeather(self.weatherManager, weather: weather)
//            } else {
//                self.didFailWithError(message: "We didn't find the city you're looking for")
//            }
//        }
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        cityTextField.resignFirstResponder()
//        return true
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        } else {
//            textField.placeholder = "Type a City name here"
//            return false
//        }
//    }
//}
////MARK: - LocationManager
//extension WeatherViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//
//            WeatherManager.shared.getCurrentLocationWeather(latitude: lat, longitude: lon) { (success, weather) in
//                self.toggleActivityIndicator(shown: true)
//                if success, let weather = weather {
//                    self.toggleActivityIndicator(shown: false)
//                    self.didUpdateCurrentWeather(self.weatherManager, currentWeather: weather)
//                } else {
//                    self.didFailWithError(message: "We didn't get your current location")
//                }
//            }
//            locationManager.stopUpdatingLocation()
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        didFailWithError(message: "We didn't get your location")
//    }
//    fileprivate func toggleActivityIndicator(shown: Bool) {
//        activityIndicator.isHidden = !shown
//        allUIStackView.isHidden = shown
//    }
//}
//
//
//  WeatherTableViewController.swift
//  Travel
//
//  Created by Graphic Influence on 10/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//
//
//import UIKit
//import CoreLocation
//
//class WeatherTableViewController: UITableViewController {
//
//
//    var weatherList = [WeatherModel]()
//    var weatherManager = WeatherManager.shared
//    let locationManager = CLLocationManager()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addSeveralCities()
//
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//        tableView.reloadData()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        print("\(weatherList.count) nombre d'élément dans weather list")
//        return weatherList.count
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destinationVC = segue.destination as? DetailWeatherViewController else { return }
//
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        destinationVC.selectedCity = weatherList[indexPath.row]
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "DetailWeather", sender: weatherList[indexPath.row])
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
//        let city = weatherList[indexPath.row]
//        cell.cityLabel.text = city.cityName
//        cell.tempLabel.text = city.temperature.doubleToStringOneDecimal()
//        cell.conditionImageView.image = UIImage(named: "\(city.conditionName)")
//        cell.setupCell()
//        return cell
//    }
//
//    @IBAction func addPressed(_ sender: UIBarButtonItem) {
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add a new city", message: "", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
//            guard let textFieldText = textField.text else { return }
//            DispatchQueue.main.async {
//                WeatherManager.shared.getCity(city: textFieldText) { (success, weather) in
//                    if success, let weather = weather {
//                        self.weatherList.append(weather)
//                        self.tableView.reloadData()
//
//                    } else {
//                        self.didFailWithError(message: "Not possible to get the server")
//                    }
//                }
//            }
//
//        }))
//        alert.addTextField { (actionTextField) in
//            actionTextField.placeholder = "Type a city name"
//            textField = actionTextField
//        }
//        present(alert, animated: true)
//    }
//
//    @IBAction func refreshPressed(_ sender: UIBarButtonItem) {
//        weatherList.removeAll()
//        addSeveralCities()
//        locationManager.requestLocation()
//        tableView.reloadData()
//    }
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            weatherList.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    fileprivate func addSeveralCities() {
//
//        WeatherManager.shared.getCity(city: "paris") { (success, weather) in
//            DispatchQueue.main.async {
//                if success, let paris = weather {
//                    self.weatherList.append(paris)
//                    //                    group.leave()
//                } else {
//                    self.didFailWithError(message: "Not possible to get the server")
//                }
//            }
//        }
//
//        WeatherManager.shared.getCity(city: "new%20york") { (success, weather) in
//            DispatchQueue.main.async {
//                if success, let newyork = weather {
//                    self.weatherList.append(newyork)
//                } else {
//                    self.didFailWithSpecialError(message: "Something went bad in getting the weather for NYC. ")
//                }
//            }
//        }
//        tableView.reloadData()
//    }
//}
//
//extension WeatherTableViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            DispatchQueue.main.async {
//                WeatherManager.shared.getCurrentLocationW(latitude: lat, longitude: lon) { (success, weather) in
//                    if success, let weather = weather { self.weatherList.append(weather)
//                        self.tableView.reloadData()
//                    } else {
//                        self.didFailWithError(message: "Not possible to get your current location")
//                    }
//                }
//            }
//            locationManager.stopUpdatingLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        didFailWithError(message: "Not possible to get your current location")
//    }
//}
//
//extension WeatherTableViewController {
//
//    func didFailWithSpecialError(message: String) {
//        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//            self.addSeveralCities()
//        }))
//        present(ac, animated: true)
//    }
//
//}
