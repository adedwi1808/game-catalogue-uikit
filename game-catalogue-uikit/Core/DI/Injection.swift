//
//  Injection.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Foundation

final class Injection: NSObject {

    private func provideRepository() -> GameRepositoryProtocol {
        let realm = RealmManager()
        let networker = Networker()

        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance(
            networker
        )

        return GameRepository.sharedInstance(locale, remote)
    }

    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }

    func provideGameDetail() -> GameDetailUseCase {
        let repository = provideRepository()
        return GameDetailInteractor(repository: repository)
    }

}
