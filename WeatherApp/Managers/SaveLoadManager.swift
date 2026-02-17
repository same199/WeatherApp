//
//  SaveLoadManager.swift
//  WeatherApp
//
//  Created by LizOk&Same on 17.02.26.
//

import Foundation


public enum Keys: String {
    case savedCityKey
}

final class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
    
    func saveCities(_ cities: [CityResponse]) {
        do {
            let data = try JSONEncoder().encode(cities)
            defaults.set(data, forKey: Keys.savedCityKey.rawValue)
        } catch {
            print("Ошибка сохранения городов: \(error)")
        }
    }
    
    func loadCities() -> [CityResponse] {
        guard let data = defaults.data(forKey: Keys.savedCityKey.rawValue) else {
            return []
        }
        do {
            return try JSONDecoder().decode([CityResponse].self, from: data)
        } catch {
            print("Ошибка загрузки городов: \(error)")
            return []
        }
    }
}
