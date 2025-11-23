//
//  NetworkerProtocol.swift
//  tourism-app
//
//  Created by Ade Dwi Prayitno on 18/11/25.
//


import UIKit

final class Networker: NetworkerProtocol {
    var data: Data = Data()
    var response: URLResponse = URLResponse()
    func taskAsync<T: Sendable>(type: T.Type, endPoint: NetworkFactory, isMultipart: Bool) async throws -> T where T: Decodable {
        do {
            try await self.isMultipart(endPoint: endPoint, isMultipart: isMultipart)
        } catch {
            throw NetworkError.internetError(message: "Connection Error")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.middlewareError(code: 500, message: "Connection Error")
        }
        
#if DEBUG
        let dataString = String(decoding: data, as: UTF8.self)
        print("Endpoint: \(endPoint.path)")
        print("Request: \(endPoint.bodyParam ?? ["":""])")
        print("Response : \(dataString)")
#endif
        
        guard 200..<300 ~= httpResponse.statusCode else {
            let res  = try? JSONDecoder().decode(NetworkHandle.self, from: data)
            
            switch httpResponse.statusCode {
            case 400:
                throw NetworkError.badRequest(message: res?.error ?? "Something went wrong")
            case 401:
                throw NetworkError.unAuthorized
            default:
                throw NetworkError.middlewareError(code: 500, message: res?.error ?? "Something went wrong")
            }
        }
        
        do {
            let decoder = JSONDecoder()
            let dataNew = try decoder.decode(type, from: data)
            return dataNew
        } catch let decodingError as DecodingError {
#if DEBUG
            print(decodingError)
#endif
            throw NetworkError.decodingError(message: "Something went wrong")
        }
    }
}

extension Networker {
    private func isMultipart(endPoint: NetworkFactory, isMultipart: Bool) async throws {
        if isMultipart {
            let body = try endPoint.createBodyWithParameters(
                parameters: endPoint.bodyParam ?? [:],
                imageDataKey: endPoint.data
            )
            
            let (data, response) = try await URLSession.shared.upload(
                for: endPoint.urlRequestMultiPart,
                from: body
            )
            
            self.data = data
            self.response = response
        } else {
            let (data, response) = try await URLSession.shared.data(for: endPoint.urlRequest)
            self.data = data
            self.response = response
        }
    }
}
