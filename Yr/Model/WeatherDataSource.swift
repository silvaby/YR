//
//  WeatherDataSource.swift
//  Yr
//
//  Created by Dzmitry on 16.12.20.
//

import Foundation

class WeatherDataSource: LocationServiceDelegate {
    private var lat = 53.920705
    private var lon = 27.461407
    private let locationService = LocationService()
    private var onWeatherUpdated: (([Weather]) -> Void)?

    init(onUpdate: @escaping (([Weather]) -> Void)) {
        onWeatherUpdated = onUpdate
        locationService.delegate = self
        locationService.setupLocation()
    }

    func locationUpdated(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        getWeather(completion: onWeatherUpdated)
    }

    /**
     Receives a weather.

     - Parameters:
       - completion: A completion handler that is called upon
       getting the weather. Takes the array of `Weather` objects. If an
       error occurred while receiving users, the array is empty.
     */
    private func getWeather(completion: (([Weather]) -> Void)?) {
        NetworkService().weatherRequest(lat: lat, lon: lon) { result in
            switch result {
            case .failure:
                completion?([])
            case let .success(data):
                var weather = [Weather]()
                if let array = try? JSONDecoder().decode(Weather.self, from: data) {
                    weather.append(array)
                    completion?(weather)
                } else {
                    completion?([])
                }
            }
        }
    }
}
