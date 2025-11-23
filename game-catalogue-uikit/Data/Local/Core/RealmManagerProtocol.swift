//
//  RealmManagerProtocol.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//


import Foundation
import RealmSwift

protocol RealmManagerProtocol: AnyObject {
    func fetch<T: Object>(type: T.Type) async throws -> [T]
    func fetch<T: Object>(type: T.Type, filter: String) async throws -> [T]
    func save<T: Object>(object: T) async throws
    func save<T: Object>(objects: [T]) async throws
    func delete<T: Object>(object: T) async throws
    func deleteAll<T: Object>(type: T.Type) async throws
}
