//
//  MockApiService.swift
//  InglewoodTests
//
//  Created by David Maksa on 28.11.22.
//

import Foundation
@testable import Inglewood

class MockApiService: APIService {
    
    let vehicules: [Vehicule]
    
    init(vehicules: [Vehicule]) {
        self.vehicules = vehicules
    }
    
    func getVehicules(completion: @escaping ([Inglewood.Vehicule]?, Error?) -> ()) {
        DispatchQueue.global().async {
            completion(self.vehicules, nil)
        }
    }
    
    func getVehiculeDetails(id: String, completion: @escaping (Inglewood.Vehicule?, Error?) -> ()) {
        DispatchQueue.global().async {
            completion(self.vehicules.first(where: { $0.vehicleId == id }), nil)
        }
    }
    
}
