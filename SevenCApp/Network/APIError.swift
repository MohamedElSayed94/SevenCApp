//
//  APIError.swift
//  SevenCApp
//
//  Created by MohamedSaidZC on 01/11/2023.
//

import Foundation

enum APIError: Error, CustomStringConvertible, Equatable {
    
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        // for users display
        switch self {
        case .badURL, .parsing, .unknown:
            return "SomeThing went wrong."
        case .badResponse:
            return "The connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
    
    var description: String {
        // for debuging description
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error): return error?.localizedDescription ?? "url session error"
        case .parsing(let error): return error?.localizedDescription ?? "parsing error"
        case .badResponse(statusCode: let statusCode): return "bad response with status code \(statusCode)"
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        lhs.description == rhs.description
    }
}
