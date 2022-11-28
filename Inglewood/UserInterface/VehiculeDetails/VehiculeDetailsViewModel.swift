//
//  VehiculeDetailsViewModel.swift
//  Inglewood
//
//  Created by David Maksa on 28.11.22.
//

import Foundation
import Combine

class VehiculeDetailsViewModel {

    private let vehiculesRepository: VehiculesRepository
    private let vehiculeId: String
    private(set) var vehicule: Vehicule?
    private var cancellable: Cancellable?
    var onUpdate: (()->())?
    
    init(vehiculesRepository: VehiculesRepository, vehiculeId: String) {
        self.vehiculesRepository = vehiculesRepository
        self.vehiculeId = vehiculeId
        subscribe()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}

// Mark: - Private

private extension VehiculeDetailsViewModel {
    
    func subscribe() {
        Task { [weak self] in
            let vehiculeId = self?.vehiculeId
            cancellable = await vehiculesRepository.vehiculesPublisher
                .throttle(for: 0.1, scheduler: RunLoop.main, latest: true)
                .map { $0.first { $0.vehicleId == vehiculeId } }
                .sink(receiveValue: { [weak self] vehicule in
                    if let vehicule = vehicule {
                        self?.vehicule = vehicule
                        self?.onUpdate?()
                    }
                })
        }
    }

}
