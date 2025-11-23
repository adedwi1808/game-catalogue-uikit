//
//  HomeViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func onSuccess()
    func onFailed(message: String)
}

@MainActor
final class HomeViewModel {
    var query: String = ""
    var page: Int = 1
    private var pageSize: Int = 10
    
    var games: [Game] = []
    weak var delegate: HomeViewModelProtocol? = nil
    
    private let services: HomeServicesProtocol
    
    init(services: HomeServicesProtocol) {
        self.services = services
    }
    
    func getGames() async {
        do {
            let response = try await services.getGames(endPoint: .getGames(search: query, page: page, pageSize: pageSize))
            let newGames: [Game] = response.results?.toDomain() ?? []
            games = page > 1 ? games + newGames : newGames
            delegate?.onSuccess()
        } catch let error {
            if error is NetworkError {
                print(error.localizedDescription)
                delegate?.onFailed(message: error.localizedDescription)
            }
        }
    }
    
    func createDetailViewModel(for index: Int) -> GameDetailViewModel {
        let selectedGame = games[index]
        let detailServices = services.makeGameDetailServices()
        let detailViewModel = GameDetailViewModel(services: detailServices)
        detailViewModel.configureDataFromList(data: selectedGame)
        
        return detailViewModel
    }
}
