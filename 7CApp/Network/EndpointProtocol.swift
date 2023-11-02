//
//  EndpointProtocol.swift
//  Giphy Picnic
//
//  Created by MohamedSaidZC on 27/07/2023.
//

import Foundation


protocol EndpointProtocol {
    
    var url: String { get }
    var method: HttpMethod { get }
    var parameters: Dictionary<String, String> { get }
    associatedtype Model: Decodable
}

enum HttpMethod: String {
    case Post                    = "POST"
    case Get                     = "GET"
    case Put                     = "PUT"
    case Delete                  = "DELETE"
}
