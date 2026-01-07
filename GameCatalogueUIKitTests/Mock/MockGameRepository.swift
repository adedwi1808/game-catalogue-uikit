//
//  MockGameRepository.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

@testable import game_catalogue_uikit

class MockGameRepository: GameRepositoryProtocol {
    var gamesResult: Result<[Game], Error> = .success([])

    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error> {
        return gamesResult.publisher.eraseToAnyPublisher()
    }

    // Implementasi dummy untuk fungsi lain yang diwajibkan protocol (jika ada)
    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, Error> {
        return Empty().eraseToAnyPublisher()
    }
    func saveToFavorite(game: Game) -> AnyPublisher<Void, Error> {
        return Empty().eraseToAnyPublisher()
    }
    func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error> {
        return Empty().eraseToAnyPublisher()
    }
    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getLocaleGames() -> AnyPublisher<[Game], Error> {
        return Empty().eraseToAnyPublisher()
    }
}
