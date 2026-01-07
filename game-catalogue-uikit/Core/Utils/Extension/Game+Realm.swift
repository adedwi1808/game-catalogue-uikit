//
//  Game+Realm.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation
import RealmSwift

extension Game {
    func toEntity() -> GameEntity {
        let entity = GameEntity()
        entity.id = self.id
        entity.name = self.name
        entity.released = self.released
        entity.backgroundImage = self.backgroundImage
        entity.rating = self.rating
        entity.ratingCount = self.ratingCount
        entity.desc = self.description
        entity.added = self.added
        entity.developers = self.developers

        let genreEntities = self.genres.map { genre in
            let genre = GenreEntity()
            genre.id = genre.id
            genre.name = genre.name
            return genre
        }
        entity.genres.append(objectsIn: genreEntities)

        let platformEntities = self.platforms.map { platform in
            let platform = PlatformEntity()
            platform.id = platform.id
            platform.name = platform.name
            platform.slug = platform.slug
            return platform
        }
        entity.platforms.append(objectsIn: platformEntities)

        return entity
    }
}

extension GameEntity {
    func toDomain() -> Game {
        return Game(
            id: self.id,
            name: self.name,
            released: self.released,
            backgroundImage: self.backgroundImage,
            rating: self.rating,
            ratingCount: self.ratingCount,
            platforms: self.platforms.map { PlatformElement(id: $0.id, name: $0.name, slug: $0.slug) },
            genres: self.genres.map { Genre(id: $0.id, name: $0.name) },
            description: self.desc,
            added: self.added,
            developers: self.developers
        )
    }
}
