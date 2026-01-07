//
//  LocaleDataSource.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Combine
import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func saveToFavorite(game: GameEntity) -> AnyPublisher<Void, Error>
    func removeFromFavorite(game: GameEntity) -> AnyPublisher<Void, Error>
    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func getLocaleGames() -> AnyPublisher<[GameEntity], Error>
}

final class LocaleDataSource: NSObject {

    private let realm: RealmManagerProtocol?

    private init(realm: RealmManagerProtocol?) {
        self.realm = realm
    }

    static let sharedInstance: (RealmManagerProtocol?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }

}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func saveToFavorite(game: GameEntity) -> AnyPublisher<Void, any Error> {
        return Future { completion in
            Task {
                guard let realm = self.realm else {
                    completion(.failure(DatabaseError.invalidInstance))
                    return
                }

                do {
                    try await realm.save(object: game)
                    completion(.success(()))
                } catch {
                    completion(
                        .failure(
                            DatabaseError.writeFailed(
                                message: "Failed to Save Game to Favorite"
                            )
                        )
                    )
                }

            }
        }.eraseToAnyPublisher()
    }

    func removeFromFavorite(game: GameEntity) -> AnyPublisher<Void, any Error> {
        return Future { completion in
            Task {
                guard let realm = self.realm else {
                    completion(.failure(DatabaseError.invalidInstance))
                    return
                }
                do {
                    try await realm.delete(object: game)
                    completion(.success(()))
                } catch {
                    completion(
                        .failure(
                            DatabaseError.writeFailed(
                                message: "Delete Failed"
                            )
                        )
                    )
                }

            }
        }.eraseToAnyPublisher()
    }

    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return Future { completion in
            Task {
                guard let realm = self.realm else {
                    completion(.failure(DatabaseError.invalidInstance))
                    return
                }

                do {
                    let results = try await realm.fetch(
                        type: GameEntity.self,
                        filter: "id == \(id)"
                    )
                    completion(.success(!results.isEmpty))
                } catch {
                    completion(
                        .failure(
                            DatabaseError.writeFailed(
                                message:
                                    "Oops, Something wrong!\nPlease try again"
                            )
                        )
                    )
                }

            }
        }.eraseToAnyPublisher()
    }

    func getLocaleGames() -> AnyPublisher<[GameEntity], Error> {
        Future { completion in
            Task {
                guard let realm = self.realm else {
                    completion(.failure(DatabaseError.invalidInstance))
                    return
                }

                do {
                    let games = try await realm.fetch(type: GameEntity.self)
                    completion(.success(games))
                } catch {
                    completion(
                        .failure(
                            DatabaseError.fetchFailed(
                                message:
                                    "Oops, Something wrong!\nPlease try again"
                            )
                        )
                    )
                }
            }
        }
        .eraseToAnyPublisher()
    }

}

extension Results {

    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0..<count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }

}
