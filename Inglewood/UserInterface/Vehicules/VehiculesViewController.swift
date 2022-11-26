//
//  VehiculesViewController.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import UIKit

class VehiculesViewController: UIViewController {
    
    let viewModel: VehiculesViewModel
    
    init(viewModel: VehiculesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
    
}
