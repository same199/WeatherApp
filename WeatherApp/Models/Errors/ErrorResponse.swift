//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by LizOk&Same on 31.01.26.
//

import Foundation


final class ErrorResponse: Codable {
    let cod: Int
    let message: String
    let parameters: [ErrorParameters]?
}
