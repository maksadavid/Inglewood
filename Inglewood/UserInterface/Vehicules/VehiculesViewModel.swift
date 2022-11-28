//
//  VehiculesViewModel.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import Foundation
import Combine

class VehiculesViewModel {
    
    private let vehiculesRepository: VehiculesRepository
    private let appCoordinator: AppCoordinator
    private(set) var vehicules = [Vehicule]()
    private var cancellable: Cancellable?
    var onUpdate: (()->())?
    
    init(vehiculesRepository: VehiculesRepository, appCoordinator: AppCoordinator) {
        self.vehiculesRepository = vehiculesRepository
        self.appCoordinator = appCoordinator
        subscribe()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func showVehiculeDetails(vehiculeId: String) {
        appCoordinator.showVehiculeDetails(vehiculeId: vehiculeId)
    }
    
}

// Mark: - Private

private extension VehiculesViewModel {
    
    func subscribe() {
        Task { [weak self] in
            cancellable = await vehiculesRepository.vehiculesPublisher
                .throttle(for: 0.1, scheduler: RunLoop.main, latest: true)
                .sink(receiveValue: { [weak self] vehicules in
                    self?.vehicules = vehicules
                    self?.onUpdate?()
                })
        }
    }

}
