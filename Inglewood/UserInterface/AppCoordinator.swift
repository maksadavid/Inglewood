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
    let vehiculesRepository = VehiculesRepository(apiService: APIService())
    
    func start() {
        let viewModel = VehiculesViewModel(vehiculesRepository: vehiculesRepository)
        let viewController = VehiculesViewController(viewModel: viewModel)
        rootController.pushViewController(viewController, animated: false)
    }
}
