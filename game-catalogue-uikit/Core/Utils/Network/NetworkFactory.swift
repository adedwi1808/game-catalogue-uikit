//
//  NetworkFactory.swift
//  tourism-app
//
//  Created by Ade Dwi Prayitno on 18/11/25.
//

import Foundation

enum NetworkFactory {
    case getGames(search: String, page: Int, pageSize: Int)
    case getGameDetail(id: Int)
}

extension NetworkFactory {

    // MARK: URL PATH API
    var path: String {
        switch self {
        case .getGames:
            return "/api/games"
        case .getGameDetail(let id):
            return "/api/games/\(id)"
        }
    }

    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .getGames(let search, let page, let pageSize):
            return [
                URLQueryItem(name: "search", value: search),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "page_size", value: String(pageSize))
            ]
        default:
            return []
        }
    }

    var bodyParam: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        default:
            return "api.rawg.io"
        }
    }

    var apiKey: URLQueryItem {
        URLQueryItem(name: "key", value: "412b96c6d0fc45a29aceaf2bdb16d6af")
    }

    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        let finalParams: [URLQueryItem] = self.queryItems + [self.apiKey]
        components.path = path
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }

    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        default:
            return .get
        }
    }

    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }

    var boundary: String {
        let boundary: String = "Boundary-12345"
        return boundary
    }

    // MARK: MULTIPART DATA
    var data: [MultipartFile]? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .getGames, .getGameDetail:
            return getHeaders(type: .anonymous)
        }
    }

    enum HeaderType {
        case anonymous
        case authorized
        case appToken
        case multiPart
        case authorizedMultipart
    }

    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        var header: [String: String]

        switch type {
        case .anonymous:
            header = [:]
        case .authorized:
            header = [
                "Content-Type": "application/json",
                "Accept": "*/*",
                "Authorization": "Basic \(setupBasicAuth())"
            ]

        case .authorizedMultipart:
            header = [
                "Content-Type": "multipart/form-data; boundary=\(boundary)",
                "Accept": "*/*",
                "Authorization": "Basic \(setupBasicAuth())"
            ]
        case .appToken:
            header = [
                "Content-Type": "application/json",
                "Accept": "*/*"
            ]
        case .multiPart:
            header = [
                "Content-Type": "multipart/form-data; boundary=\(boundary)",
                "Accept": "*/*"
            ]
        }
        return header
    }

    func createBodyWithParameters(
        parameters: [String: Any],
        imageDataKey: [MultipartFile]?
    ) throws -> Data {

        let body = NSMutableData()

        for (key, value) in parameters {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(
                Data(
                    "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
                        .utf8
                )
            )
            body.append(Data("\(value)".utf8))
            body.append(Data("\r\n".utf8))
        }

        if let imageData = imageDataKey {
            for datum in imageData where !datum.data.isEmpty {

                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(
                    Data(
                        "Content-Disposition: form-data; name=\"\(datum.paramName)\"; filename=\"\(datum.fileName)\"\r\n"
                            .utf8
                    )
                )
                body.append(
                    Data(
                        "Content-Type: \(datum.data.mimeType)\r\n\r\n".utf8
                    )
                )
                body.append(datum.data)
                body.append(Data("\r\n".utf8))
            }
        }

        body.append(Data("--\(boundary)--\r\n".utf8))

        return body as Data
    }

    private func setupBasicAuth() -> String {
        "Access Token"
    }

    var urlRequestMultiPart: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        return urlRequest
    }

    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url, timeoutInterval: 10.0)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(
                    withJSONObject: bodyParam,
                    options: [.prettyPrinted]
                )
                urlRequest.httpBody = bodyData
            } catch {
                #if DEBUG
                    print(error)
                #endif
            }
        }
        return urlRequest
    }
}
