//
//  EndpointProtocol.swift
//  7CApp
//
//  Created by MohamedSaidZC on 01/11/2023.
//

import Foundation


protocol EndpointProtocol {
    
    var url: String { get }
    var method: HttpMethod { get }
    var parameters: Dictionary<String, String> { get }
    var headers: Dictionary<String, String> { get }
    associatedtype Model: Decodable
}

enum HttpMethod: String {
    case Post                    = "POST"
    case Get                     = "GET"
    case Put                     = "PUT"
    case Delete                  = "DELETE"
}
