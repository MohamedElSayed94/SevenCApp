//
//  HomeViewModel.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Combine

protocol HomeViewModelProtocol {
    func fetchHome()
}

class HomeViewModel: HomeViewModelProtocol {
    
    let service: NetworkServiceProtocol
    var cancellable: [AnyCancellable] = []
    //MARK: - init
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.service = networkService
        
    }
    
    func fetchHome() {
        let endPoint = GetHomeEndPoint()
        service.request(endPoint).sink { completion in
            switch completion {
            case .finished:
                ()
            case .failure(let error):
                print(error)
                
            }
        } receiveValue: { [weak self] homeModel in
            guard let self else { return }
            print(homeModel)
        }
        .store(in: &cancellable)

    }
}
