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
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error, message: String)
}

class WeatherManager {
    //MARK: - Singleton
    static var shared = WeatherManager()
    private init() {}
    //MARK: - Instanciations
    private let api = Apikey()
    var delegate: WeatherManagerDelegate?
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    

    private static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid="

    func getCity(city: String) {
        let urlString = "\(WeatherManager.weatherURL)\(api.weatherApiKey)&q=\(city)"
        print(urlString)
        performRequest(with: urlString)
    }

    func getCurrentLocationWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(WeatherManager.weatherURL)\(api.weatherApiKey)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    func performRequest(with url: String) {
        if let url = URL(string: url) {
            task?.cancel()
            task = self.session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task?.resume()
        }
    }

    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let name = decodeData.name
            let temp = decodeData.main.temp


            let weather = WeatherModel(temperature: temp, condition: id, cityName: name)
            return weather
        } catch {
            delegate?.didFailWithError(error, message: "We didn't get the datas from the server")
            return nil
        }
    }
    
}
