//
//  LocationServiceDelegate.swift
//  Yr
//
//  Created by Dzmitry on 16.12.20.
//

protocol LocationServiceDelegate: AnyObject {
    func locationUpdated(lat: Double, lon: Double)
}
