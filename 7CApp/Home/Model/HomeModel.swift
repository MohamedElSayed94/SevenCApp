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
    
    init(slider: [HomeItem] = [], categories: [HomeItem] = [], weeklyProducts: [Product] = [], topProducts: [Product] = [], ads: [HomeItem] = []) {
        self.slider = slider
        self.categories = categories
        self.weeklyProducts = weeklyProducts
        self.topProducts = topProducts
        self.ads = ads
    }
}

struct HomeItem: Decodable {
    let id: Int?
    let name: String
    let image: String
    
    init(id: Int? = nil, name: String = "", image: String = "") {
        self.id = id
        self.name = name
        self.image = image
    }
}

struct Product: Decodable {
    let id: Int
    let name: String
    let image: String
    let offer: String
    let priceOffer: String?
    let price: String
    
    init(id: Int = 0, name: String = "", image: String = "", offer: String = "", priceOffer: String? = nil, price: String = "") {
        self.id = id
        self.name = name
        self.image = image
        self.offer = offer
        self.priceOffer = priceOffer
        self.price = price
    }
}

