//
//  HomeViewModel.swift
//  SevenCApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import Combine

protocol HomeViewModelProtocol {
    var state: CurrentValueSubject<ViewModelState, Never> { get }
    var model: HomeModel { get }
    func fetchHome()
    func getItemsCount(section: HomeViewController.Section) -> Int
}

class HomeViewModel: HomeViewModelProtocol {
    
    let service: NetworkServiceProtocol
    var state = CurrentValueSubject<ViewModelState, Never>(.initial)
    var model = HomeModel()
    var cancellable: [AnyCancellable] = []
    //MARK: - init
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.service = networkService
        
    }
    
    func fetchHome() {
        let endPoint = GetHomeEndPoint()
        state.send(.loading)
        service.request(endPoint).sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
                self.state.send(.failed(error))
                
            }
        } receiveValue: { [weak self] response in
            guard let self else { return }
            self.model = response.data
            state.send(.loaded)
        }
        .store(in: &cancellable)

    }
    
    func getItemsCount(section: HomeViewController.Section) -> Int {
        switch section {
        case .categories:
            model.categories.count
        case .slider:
            model.slider.count
        case .weeklySelection:
            model.weeklyProducts.count
        case .ads:
            model.ads.count
        case .topProducts:
            model.topProducts.count
        }
    }
}
