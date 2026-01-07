//
//  NetworkerProtocol.swift
//  tourism-app
//
//  Created by Ade Dwi Prayitno on 18/11/25.
//

import Foundation

protocol NetworkerProtocol: AnyObject {
    func taskAsync<T>(type: T.Type,
                      endPoint: NetworkFactory,
                      isMultipart: Bool
    ) async throws -> T where T: Decodable
}
