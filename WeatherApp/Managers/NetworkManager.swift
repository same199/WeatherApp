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
}

class NetworkManager: INetworkManager {
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherResponse) -> Void) {
        // Формируем query с координатами
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
                print("Error decoding WeatherResponse: \(error)")
            }
        }.resume()
    }
}
