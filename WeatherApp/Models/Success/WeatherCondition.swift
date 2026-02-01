//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by LizOk&Same on 1.02.26.
//

import Foundation

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
