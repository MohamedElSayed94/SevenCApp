//
//  ViewModelState.swift
//  SevenCApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Foundation

enum ViewModelState: Equatable {
    case initial
    case loading
    case failed(APIError)
    case loaded
    
}
