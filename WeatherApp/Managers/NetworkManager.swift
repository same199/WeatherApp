//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by LizOk&Same on 31.01.26.
//

import Foundation
import Reachability


enum RequestType: String {
    case get
    case post
}



protocol INetworkManager {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherResponse) -> Void)
    func searchCity(name: String, completion: @escaping ([CityResponse]) -> Void)
}

class NetworkManager: INetworkManager {
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherResponse) -> Void) {
        let query = "lat=\(lat)&lon=\(lon)&exclude=\(Params.excludedMinutely.rawValue),\(Params.excludedHourly.rawValue),\(Params.excludedDaily.rawValue),\(Params.excludedAlerts.rawValue)&units=\(Params.unitsMetric.rawValue)&appid=\(APIKeys.openWeatherToken.rawValue)"
        guard let url = URL(string: "\(Params.baseURL.rawValue)\(query)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = RequestType.get.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else { return }
            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch {
                print("Ошибка декодирования погоды \(error)")
            }
        }.resume()
    }
    
    func searchCity(name: String, completion: @escaping ([CityResponse]) -> Void) {
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        let query = "q=\(encodedName)&limit=\(IntParams.five)&appid=\(APIKeys.openWeatherToken.rawValue)"
        guard let url = URL(string: "\(Params.baseCityURL.rawValue)\(query)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }
            do {
                let cities = try JSONDecoder().decode([CityResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(cities)
                }
            } catch {
                print("Ошибка декодирования городов:, \(error)")
            }
        }.resume()
    }
}
