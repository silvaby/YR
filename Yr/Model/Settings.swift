//
//  Settings.swift
//  Yr
//
//  Created by Dzmitry on 19.12.20.
//

import Foundation

final class Settings {
    private enum Keys: String {
        case data
    }

    private let defaults = UserDefaults.standard

    func saveToUserDefaults(data: [Weather]) {
        do {
            let data = try JSONEncoder().encode(data)
            defaults.set(data, forKey: Keys.data.rawValue)
        } catch {
            print(error)
        }
    }

    func getDataFromUserDefaults() -> [Weather]? {
        var storedWeather = [Weather]()
        do {
            if let data = defaults.data(forKey: Keys.data.rawValue) {
                storedWeather = try JSONDecoder().decode([Weather].self, from: data)
            }
        } catch {
            print(error)
        }
        return storedWeather
    }
}
