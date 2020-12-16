//
//  ViewController.swift
//  Yr
//
//  Created by Dzmitry on 12.12.20.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties

    private var airTemperature = "--"
    private var airTemperatureLabel: UILabel?
    private var dataSource: WeatherDataSource?
    private var weather = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        airTemperatureLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200.00, height: 40.00))
        if let airTemperatureLabel = airTemperatureLabel {
            view.addSubview(airTemperatureLabel)
            airTemperatureLabel.text = "--"
            airTemperatureLabel.textAlignment = .center
        }
        requestWeatherForLocation()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        requestWeatherForLocation()
    }

    func requestWeatherForLocation() {
        dataSource = WeatherDataSource { [weak self] data in
            self?.weather = data

            if let airTemperature = self?.weather.first?.properties.timeseries.first?.data.instant.details.airTemperature {
                self?.airTemperature = String(airTemperature)
            }
            DispatchQueue.main.async {
                self?.airTemperatureLabel?.text = "\(self!.airTemperature) \u{2103}"
            }
        }
    }
}
