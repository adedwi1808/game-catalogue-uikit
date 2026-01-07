//
//  MockData.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

@testable import game_catalogue_uikit

struct MockData {
    static let sampleGame = Game(
        id: 1,
        name: "Test Game",
        released: "2020-01-01",
        backgroundImage: nil,
        rating: 4.5,
        ratingCount: 100,
        platforms: [],
        genres: [],
        description: "Description",
        added: nil,
        developers: nil
    )
}
