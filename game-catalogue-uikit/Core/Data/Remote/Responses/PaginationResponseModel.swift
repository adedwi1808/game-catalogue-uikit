//
//  PaginationResponseModel.swift
//  tourism-app
//
//  Created by Ade Dwi Prayitno on 18/11/25.
//

struct PaginationResponseModel<T>: Codable where T: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [T]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}
