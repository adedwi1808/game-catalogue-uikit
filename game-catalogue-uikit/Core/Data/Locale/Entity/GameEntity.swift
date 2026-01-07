//
//  GameRealmModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import RealmSwift
import Foundation

// MARK: - Game Entity
class GameEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var released: String = ""
    @Persisted var backgroundImage: String?
    @Persisted var rating: Double?
    @Persisted var ratingCount: Int?
    @Persisted var desc: String?
    @Persisted var added: Int?

    @Persisted var platforms = List<PlatformEntity>()
    @Persisted var genres = List<GenreEntity>()
    @Persisted var developers: String?

    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

// MARK: - Genre Entity
class GenreEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
}

// MARK: - Platform Entity
class PlatformEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var slug: String = ""
}
