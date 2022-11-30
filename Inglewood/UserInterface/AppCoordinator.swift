//
//  AppCoordinator.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import Foundation
import UIKit

class AppCoordinator {
    
    let rootController = UINavigationController()
    let vehiculesRepository = VehiculesRepository(apiService: APIServiceImpl())
    
    func start() {
        let viewModel = VehiculesViewModel(
            vehiculesRepository: vehiculesRepository,
            appCoordinator: self
        )
        let viewController = VehiculesViewController(viewModel: viewModel)
        rootController.pushViewController(viewController, animated: false)
    }
    
    func showVehiculeDetails(vehiculeId: String) {
        let viewModel = VehiculeDetailsViewModel(
            vehiculesRepository: vehiculesRepository,
            vehiculeId: vehiculeId
        )
        let viewController = VehiculeDetailsViewController(viewModel: viewModel)
        rootController.pushViewController(viewController, animated: true)
    }
}
