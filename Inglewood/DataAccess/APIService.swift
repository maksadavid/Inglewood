//
//  APIService.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import Foundation

class APIService {
    
    let baseUrl = URL(string:"https://5w53f1x8oa.execute-api.eu-west-1.amazonaws.com/dev")!
    let apiKey = "tpdsRCyD8t2fcokyUmBuo2wBxXS5S726Pe3fIaXd"
    let authHeader = "x-api-key"
    
    func getVehicules(completion: @escaping ([Vehicule]?, Error?) ->()) {
        var request = URLRequest(url: baseUrl.appendingPathComponent("vehicles"))
        request.addValue(apiKey, forHTTPHeaderField: authHeader)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if error == nil,
               let data = data,
               let vehicules = try? JSONDecoder().decode([Vehicule].self, from: data) {
                completion(vehicules, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
    func getVehiculeDetails(id: String, completion: @escaping (Vehicule?, Error?) ->()) {
        var request = URLRequest(url: baseUrl.appendingPathComponent("vehicles/\(id)"))
        request.addValue(apiKey, forHTTPHeaderField: authHeader)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if error == nil,
               let data = data,
               let vehicule = try? JSONDecoder().decode(Vehicule.self, from: data) {
                completion(vehicule, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
}
