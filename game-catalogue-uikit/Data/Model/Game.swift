//
//  Game.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//


struct Game {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String?
    let rating: Double?
    let ratingCount: Int?
    let platforms: [PlatformElement]
    let genres: [Genre]
    let description: String?
    let added: Int?
    let developers: String?
}

struct Genre {
    let id: Int
    let name: String
}

struct PlatformElement {
    let id: Int
    let name: String
    let slug: String
}
