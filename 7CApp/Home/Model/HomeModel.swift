//
//  HomeModel.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Foundation

struct HomeModel: Decodable {
    let slider: [HomeItem]
    let categories: [HomeItem]
    let weeklyProducts: [Product]
    let topProducts: [Product]
    let ads: [HomeItem]
    
    
}

struct HomeItem: Decodable {
    let id: Int?
    let name: String
    let image: String
}

struct Product: Decodable {
    let id: Int
    let name: String
    let image: String
    let offer: String
    let priceOffer: String?
    let price: String
}
