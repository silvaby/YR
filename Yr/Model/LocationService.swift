//
//  LocationService.swift
//  Yr
//
//  Created by Dzmitry on 16.12.20.
//

import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationServiceDelegate?
    private let locationManager = CLLocationManager()

    func setupLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.distanceFilter = 1000
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        delegate?.locationUpdated(lat: location.latitude, lon: location.longitude)
    }
}
