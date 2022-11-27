//
//  VehiculesRepository.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import Foundation
import Combine

class VehiculesRepository {
        
    private let apiService: APIService
    private var timer: Timer?
    private let vehiculeStore = VehiculeStore()
    
    var vehiculesPublisher: AnyPublisher<[Vehicule], Never> {
        get async { await vehiculeStore.publisher }
    }
    
    init(apiService: APIService) {
        self.apiService = apiService
        updateVehicules()
        self.timer = Timer.scheduledTimer(
            timeInterval: 5,
            target: self,
            selector: #selector(updateVehicules),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateVehicules() {
        apiService.getVehicules { [weak self] vehicules, error in
            guard let self = self, error == nil, let vehicules = vehicules else {
                return
            }
            Task {
                await self.vehiculeStore.addVehicules(vehicules)
                let vehiculeIds = await self.vehiculeStore.getVehiculeIds()
                self.fetchLocations(vehiculeIds: vehiculeIds)
            }
        }
    }
    
}

// Mark: - Private

private extension VehiculesRepository {
    
    func fetchLocations(vehiculeIds: [String]) {
        vehiculeIds.forEach {
            apiService.getVehiculeDetails(id: $0) { [weak self] vehicule, error in
                guard let self = self, let vehicule = vehicule, error == nil else {
                    return
                }
                Task {
                    await self.vehiculeStore.updateVehicule(vehicule)
                }
            }
        }
    }
    
}
