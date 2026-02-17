//
//  CityResponse.swift
//  WeatherApp
//
//  Created by LizOk&Same on 15.02.26.
//


struct CityResponse: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let Country: String

    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
        case Country = "country"
    }
}
