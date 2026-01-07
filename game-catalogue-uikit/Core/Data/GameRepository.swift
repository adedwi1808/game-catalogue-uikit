//
//  GameRepository.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Combine
import Foundation

protocol GameRepositoryProtocol {
    // Locale
    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error>
    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, Error>

    // Remote
    func saveToFavorite(game: Game) -> AnyPublisher<Void, Error>
    func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error>
    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func getLocaleGames() -> AnyPublisher<[Game], Error>
}

final class GameRepository: NSObject {

    typealias GameInstance = (LocaleDataSource, RemoteDataSource) ->
        GameRepository

    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource

    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }

    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }

}

extension GameRepository: GameRepositoryProtocol {
    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error> {
        return self.remote.getGames(endPoint: endPoint)
            .compactMap { response in
                response.results?.compactMap { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }

    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<
        Game, any Error
    > {
        return self.remote.getGameDetail(endPoint: endPoint)
            .map {
                $0.toDomain()
            }
            .eraseToAnyPublisher()
    }

    func saveToFavorite(game: Game) -> AnyPublisher<Void, Error> {
        return self.locale.saveToFavorite(
            game: game.toEntity()
        ).eraseToAnyPublisher()
    }

    func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error> {
        return self.locale
            .removeFromFavorite(game: game.toEntity())
            .eraseToAnyPublisher()
    }

    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.locale
            .checkIsFavorite(id: id)
            .eraseToAnyPublisher()
    }

    func getLocaleGames() -> AnyPublisher<[Game], Error> {
        return self.locale
            .getLocaleGames()
            .map { $0.map { $0.toDomain()}}
            .eraseToAnyPublisher()
    }
}
