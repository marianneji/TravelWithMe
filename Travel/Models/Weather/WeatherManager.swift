//
//  WeatherManager.swift
//  Travel
//
//  Created by Graphic Influence on 28/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation
import CoreLocation

//MARK: - Protocols


class WeatherManager {
    //MARK: - Singleton
    static var shared = WeatherManager()
    private init() {}

    //MARK: - Instanciations
    private let apiKey = Apikeys.valueForAPIKey(named: "weatherApiKey")

    var delegate: WeatherManagerDelegate?

    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)

    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }

    private static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid="

    func getCity(city: String, callback: @escaping (Bool, WeatherModel?) -> Void) {
        var urlString = "\(WeatherManager.weatherURL)\(apiKey)&q=\(city)"

        if urlString.contains(" ") {
            urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        }
        print(urlString)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)

            task = self.weatherSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    guard let weather = self.parseJson(data) else {
                        callback(false, nil)
                        return
                    }
                    self.delegate?.didUpdateWeather(self, weather: weather)
                    callback(true, weather)
                }
            }
        }
        task?.resume()
    }


    func getCurrentLocationWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, callback: @escaping (Bool, WeatherModel?) -> Void) {
        let urlString = "\(WeatherManager.weatherURL)\(apiKey)&lat=\(latitude)&lon=\(longitude)"
        print("current location \(urlString)")
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            task = self.weatherSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    guard let weather = self.parseJson(data) else {
                        callback(false, nil)
                        return
                    }
                    self.delegate?.didUpdateWeather(self, weather: weather)
                    callback(true, weather)
                }
            }
        }
        task?.resume()
    }

    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let name = decodeData.name
            let temp = decodeData.main.temp
            let humidity = decodeData.main.humidity
            let tempMin = decodeData.main.temp_min
            let tempMax = decodeData.main.temp_max
            let windSpeed = decodeData.wind.speed
            let description = decodeData.weather[0].description
            let sunrise = decodeData.sys.sunrise
            let sunset = decodeData.sys.sunset
            let timezone = decodeData.timezone
            let dt = decodeData.dt

            let weather = WeatherModel(temperature: temp, condition: id, cityName: name, windSpeed: windSpeed, tempMin: tempMin, tempMax: tempMax, humidity: humidity, description: description, sunrise: sunrise, sunset: sunset, timeZone: timezone, dt : dt)
            return weather
        } catch {
           print(error.localizedDescription)
            return nil
        }
    }
}

