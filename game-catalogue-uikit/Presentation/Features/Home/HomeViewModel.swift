//
//  HomeViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

@MainActor
final class HomeViewModel {
    var games: [Game] = []
    var isLoading: Bool = false
    
    private let services: HomeServicesProtocol
    
    init(services: HomeServicesProtocol) {
        self.services = services
    }
    
    func getGames() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            let _ = try await services.getGames(endPoint: .getGames)
        } catch let error {
            if error is NetworkError {
                print(error.localizedDescription)
            }
        }
    }
}
