//
//  VehiculesViewController.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import UIKit

class VehiculesViewController: UIViewController {
    
    private let viewModel: VehiculesViewModel
    private let tableview = UITableView()
    
    init(viewModel: VehiculesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        viewModel.onUpdate = { [weak self] in
            self?.tableview.reloadData()
        }
    }
    
}

// Mark: - UITableViewDataSource

extension VehiculesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.vehicules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vehicule = viewModel.vehicules[indexPath.item]
        let reuseId = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) ??
        UITableViewCell(style: .subtitle, reuseIdentifier: reuseId)
        cell.textLabel?.text = vehicule.vehicleId
        if let location = vehicule.location {
            cell.detailTextLabel?.text = location.isCloseToInglewood ? "close" : "far away"
        } else {
            cell.detailTextLabel?.text = "Fetching location data ..."
        }
        return cell
    }
}

// Mark: - UITableViewDelegate

extension VehiculesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vehicule = viewModel.vehicules[indexPath.item]
        viewModel.showVehiculeDetails(vehiculeId: vehicule.vehicleId)
    }
    
}

