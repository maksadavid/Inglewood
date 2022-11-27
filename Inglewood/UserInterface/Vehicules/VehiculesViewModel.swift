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
    private(set) var vehicules = [Vehicule]()
    private var cancellable: Cancellable?
    var onUpdate: (()->())?
    
    init(vehiculesRepository: VehiculesRepository) {
        self.vehiculesRepository = vehiculesRepository
        subscribe()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}

private extension VehiculesViewModel {
    
    func subscribe() {
        Task { [weak self] in
            cancellable = await vehiculesRepository.vehiculesPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] vehicules in
                    self?.vehicules = vehicules
                    self?.onUpdate?()
                })
        }
    }

}
