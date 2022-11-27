//
//  VehiculeStore.swift
//  Inglewood
//
//  Created by David Maksa on 27.11.22.
//

import Combine

actor VehiculeStore {
    
    private let subject = CurrentValueSubject<[Vehicule], Never>([Vehicule]())
    
    var publisher: AnyPublisher<[Vehicule], Never> {
        subject.eraseToAnyPublisher()
    }
    
    func addVehicules(_ vehicules: [Vehicule]) {
        var currentVehicules = subject.value
        let newVehicules = vehicules.filter { !currentVehicules.contains($0) }
        currentVehicules.append(contentsOf: newVehicules)
        subject.send(currentVehicules)
    }
    
    func getVehiculeIds() -> [String] {
        subject.value.map { $0.vehicleId }
    }
    
    func updateVehicule(_ vehicule: Vehicule) {
        var currentVehicules = self.subject.value
        if let index = currentVehicules.firstIndex(of: vehicule) {
            currentVehicules[index] = vehicule
            self.subject.send(currentVehicules)
        }
    }

}
