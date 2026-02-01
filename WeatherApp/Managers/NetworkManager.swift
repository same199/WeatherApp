//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by LizOk&Same on 31.01.26.
//

import Foundation
import Reachability

protocol INetworkManager {
}


enum RequestType: String {
    case get
    case post
}

private let openWeatherURL = "https://api.openweathermap.org/data/3.0/onecall?"

class NetworkManager: INetworkManager {
    var isReachable: Bool {
        do {
            return try Reachability().connection != .unavailable
        } catch {
            return false
        }
    }
    
    func createRequest(completion: @escaping (WeatherResponse) -> Void) {
        
        //https://api.openweathermap.org/data/3.0/onecall?lat=33.44&lon=-94.04&exclude=minutely,hourly,daily,alerts&appid=558669
        
        let query = String("lat:\(33.44)&lon:\(-94.04)&exclude=minutely,hourly,daily,alerts&")
        let createdRequest = Request(
            httpMethod: HTTPMethod.get,
            baseURL: Params.baseURL.rawValue,
            query: query,
            apiKey: APIKeys.openWeatherToken.rawValue
        )
        makeRequest(createdRequest) { data in
            guard let data else { return }
            do{
                let success = try JSONDecoder().decode(WeatherResponse.self, from: data)
            completion(success)
            }
            catch{
                print("Error")
            }
        }
    }
    
    private func makeRequest(_ request: Request, completion: @escaping (Data?) -> Void) {
        guard var url = URL(string: "\(request.baseURL)\(request.query)\(request.apiKey)") else{
            return completion(nil)
        }
        var uRLRequest = URLRequest(url: url)
        uRLRequest.httpMethod = request.httpMethod.rawValue
        
        URLSession.shared.dataTask(with: uRLRequest) { data, response, error in
            guard error == nil else {
                return completion(nil)
            }
            completion(data)
        }.resume()
    }
}
