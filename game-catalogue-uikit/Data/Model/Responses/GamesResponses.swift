//
//  GamesResponses.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//


import Foundation

// MARK: - GamesResponse
struct GamesResponse: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingCount: Int?
    let parentPlatforms: [ParentPlatformResponse]?
    let genres: [GenreResponse]?
    let description: String?
    let added: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case parentPlatforms = "parent_platforms"
        case ratingCount = "ratings_count"
        case genres
        case description = "description_raw"
        case added
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
            ratingCount: ratingCount,
            platforms: parentPlatforms?.map { $0.toDomain() } ?? [],
            genres: genres?.map { $0.toDomain() } ?? [],
            description: description,
            added: added
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
