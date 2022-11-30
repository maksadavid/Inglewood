//
//  InglewoodTests.swift
//  InglewoodTests
//
//  Created by David Maksa on 26.11.22.
//

import XCTest
@testable import Inglewood

final class InglewoodTests: XCTestCase {
    
    var mockApiService: MockApiService!
    
    override func setUpWithError() throws {
        let vehicules = (0..<1000).map { _ in
            Vehicule(
                vehicleId: NSUUID().uuidString,
                location: Location(latitude: 46.5223916, longitude: 6.6314437)
            )
        }
        mockApiService = MockApiService(vehicules: vehicules)
    }
        
    func testVehiculesViewModel() throws {
        let viewModel = VehiculesViewModel(
            vehiculesRepository: VehiculesRepository(apiService: mockApiService),
            appCoordinator: AppCoordinator()
        )
        let expectation = XCTestExpectation(
            description: "The count of vehicules close to Inglewood will be equal to 1000"
        )
        viewModel.onUpdate = {
            guard viewModel.numberOfVehiculesCloseToInglewood == 1000 else { return }
            XCTAssertEqual(viewModel.vehicules.count, 1000)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testIsCloseToInglewood() throws {
        XCTAssertTrue(Location.inglewood.isCloseToInglewood)
        XCTAssertTrue(Location(latitude: 46.522337, longitude: 6.631446).isCloseToInglewood)
        XCTAssertFalse(Location(latitude: 46.527307, longitude: 6.609090).isCloseToInglewood)
        XCTAssertFalse(Location(latitude: 46.520886, longitude: 6.647972).isCloseToInglewood)
        XCTAssertFalse(Location(latitude: 46.537229, longitude: 6.633016).isCloseToInglewood)
        XCTAssertFalse(Location(latitude: 46.505373, longitude: 6.628129).isCloseToInglewood)
    }
    
    func testVehiculeDetailsViewModel() throws {
        let vehiculeId = mockApiService.vehicules.first!.vehicleId
        let viewModel = VehiculeDetailsViewModel(
            vehiculesRepository: VehiculesRepository(apiService: mockApiService),
            vehiculeId: vehiculeId
        )
        let expectation = XCTestExpectation(
            description: "The count of vehicules close to Inglewood will be equal to 1000"
        )
        viewModel.onUpdate = {
            guard viewModel.numberOfVehiculesCloseToInglewood == 1000 else { return }
            XCTAssertEqual(viewModel.vehicule?.vehicleId, vehiculeId)
            XCTAssertTrue(viewModel.vehicule?.location?.isCloseToInglewood ?? false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

}
