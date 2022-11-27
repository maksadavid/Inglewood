//
//  Vehicule.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import Foundation

struct Vehicule: Codable {
    let vehicleId: String
    var location: Location?
}

extension Vehicule: Equatable {
    
    static func == (lhs: Vehicule, rhs: Vehicule) -> Bool {
        lhs.vehicleId == rhs.vehicleId
    }
    
}
