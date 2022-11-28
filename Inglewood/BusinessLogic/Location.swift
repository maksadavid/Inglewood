//
//  Location.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import Foundation

struct Location: Codable {
    
    static let inglewood = Location(latitude: 46.5223916, longitude: 6.6314437)

    let latitude: Double
    let longitude: Double
    var latitudeInKm: Double { latitude * 110.574 }
    var longitudeInKm: Double { longitude * 111.32 * cos(latitude * Double.pi/180) }
    
    var isCloseToInglewood: Bool {
        let dLatitude = latitudeInKm - Location.inglewood.latitudeInKm
        let dLongitude = longitudeInKm - Location.inglewood.longitudeInKm
        return (dLongitude * dLongitude + dLatitude * dLatitude) < 1
    }
    
}
