//
//  GetHomeEndPoint.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Foundation


struct GetHomeEndPoint: EndpointProtocol {
    var url: String = "https://codexkw.co/7c/api/home_screen"
    var method = HttpMethod.Get
    var parameters: Dictionary<String, String> = [:]
    var headers: Dictionary<String, String> = [
        "Lang" : "en",
        "Auth" : authToken,
        "Currency" : "1"
    ]
    typealias Model = HomeResponseModel
}
