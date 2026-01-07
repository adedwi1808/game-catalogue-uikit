//
//  GameDetailInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

protocol GameDetailUseCase {
    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, Error>
    func saveToFavorite(game: Game) -> AnyPublisher<Void, Error>
    func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error>
    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

final class GameDetailInteractor: GameDetailUseCase {
    private let repository: GameRepositoryProtocol

    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, any Error> {
        repository.getGameDetail(endPoint: endPoint)
    }

    func saveToFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        repository.saveToFavorite(game: game)
    }

    func removeFromFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        repository.removeFromFavorite(game: game)
    }

    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        repository.checkIsFavorite(id: id)
    }
}
