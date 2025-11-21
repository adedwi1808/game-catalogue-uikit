//
//  GamesResponses.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//


import Foundation

// MARK: - GamesResponses
struct GamesResponses: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GamesResponse]?
    
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - GamesResponse
struct GamesResponse: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let parentPlatforms: [ParentPlatformResponse]?
    let genres: [GenreResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case parentPlatforms = "parent_platforms"
        case genres
    }
}



// MARK: - GenreResponse
struct GenreResponse: Codable {
    let id: Int?
    let name, slug: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}

// MARK: - ParentPlatform
struct ParentPlatformResponse: Codable {
    let platform: PlatformResponse?
}

// MARK: - PlatformResponse
struct PlatformResponse: Codable {
    let id: Int?
    let name, slug: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}

extension GamesResponse {
    func toDomain() -> Game {
        return Game(
            id: id ?? 0,
            name: name ?? "-",
            released: released ?? "-",
            backgroundImage: backgroundImage,
            rating: rating,
            platforms: parentPlatforms?.map { $0.toDomain() } ?? [],
            genres: genres?.map { $0.toDomain() } ?? []
        )
    }
}

extension ParentPlatformResponse {
    func toDomain() -> PlatformElement {
        PlatformElement(
            id: platform?.id ?? 0,
            name: platform?.name ?? "-",
            slug: platform?.slug ?? "-"
        )
    }
}

extension GenreResponse {
    func toDomain() -> Genre {
        Genre(
            id: id ?? 0,
            name: name ?? "-"
        )
    }
}
