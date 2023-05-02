//
//  CarListViewModel.swift
//  XCAChatGPT
//
//  Created by BotBaller on 2023-05-01.
//

import Foundation
import SwiftUI
import Combine

class CarListViewModel: ObservableObject {
    @Published var cars: [Car] = []

    private var cancellables = Set<AnyCancellable>()

    func fetchCars() {
        APIService.shared.fetchCars { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cars):
                    self?.cars = cars
                case .failure(let error):
                    print("Error fetching cars: \(error)")
                }
            }
        }
    }
}
