//
//  NetworkService.swift
//  SevenCApp
//
//  Created by MohamedSaidZC on 01/11/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<Endpoint: EndpointProtocol>(_ endpoint: Endpoint) -> AnyPublisher<Endpoint.Model,APIError>
}


class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private let session: URLSession
    
    // exposing URLSession through DI will make it testable
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func request<Endpoint: EndpointProtocol>(_ endpoint: Endpoint) -> AnyPublisher<Endpoint.Model,APIError> {
        
        guard let url = URL(string: endpoint.url) else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        request.allHTTPHeaderFields = endpoint.headers
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.badResponse(statusCode: httpResponse?.statusCode ?? 0)
                }
                
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    print(dict ?? "")
                } catch {
                    print(error)
                }
                
                return data
            }
            .decode(type: Endpoint.Model.self, decoder: decoder)
            .mapError({ error -> APIError in
                if let error = error as? APIError {
                    return error
                } else if error is DecodingError {
                    return APIError.parsing(error as? DecodingError)
                } else {
                    return APIError.unknown
                }
                
            })
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
