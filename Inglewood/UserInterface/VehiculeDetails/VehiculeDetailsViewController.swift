//
//  VehiculeDetailsViewController.swift
//  Inglewood
//
//  Created by David Maksa on 28.11.22.
//

import UIKit

class VehiculeDetailsViewController: UIViewController {
    
    private let viewModel: VehiculeDetailsViewModel
    private let textLabel = UILabel()
    
    init(viewModel: VehiculeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        viewModel.onUpdate = { [weak self] in
            self?.updateView()
        }
    }
    
}

// Mark: - Private

extension VehiculeDetailsViewController {
    
    func updateView() {
        if let count = viewModel.numberOfVehiculesCloseToInglewood {
            title = "close: \(count)"
        }
        guard let vehicule = viewModel.vehicule else {
            textLabel.text = ""
            return
        }
        guard let location = vehicule.location else {
            textLabel.text = vehicule.vehicleId
            return
        }
        let status = location.isCloseToInglewood ? "close" : "far away"
        textLabel.text = "\(vehicule.vehicleId)\n\(status)\n\(location.latitude)\n\(location.longitude)"
    }

}
