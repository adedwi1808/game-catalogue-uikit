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
        
        let genreEntities = self.genres.map { genre in
            let g = GenreEntity()
            g.id = genre.id
            g.name = genre.name
            return g
        }
        entity.genres.append(objectsIn: genreEntities)
        
        let platformEntities = self.platforms.map { plat in
            let p = PlatformEntity()
            p.id = plat.id
            p.name = plat.name
            p.slug = plat.slug
            return p
        }
        entity.platforms.append(objectsIn: platformEntities)
        
        return entity
    }
}
