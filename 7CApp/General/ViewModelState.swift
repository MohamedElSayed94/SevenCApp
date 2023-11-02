//
//  ViewModelState.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Foundation

enum ViewModelState {
    case initial
    case loading
    case failed(APIError)
    case loaded
    
}
