//
//  HomeViewModelTests.swift
//  SevenCAppTests
//
//  Created by Mohamed Elsayed on 03/11/2023.
//

import XCTest
import Combine
@testable import SevenCApp

final class HomeViewModelTests: XCTestCase {

    
    
    var cancellabels = [AnyCancellable]()
    func testGetHomeSuccess() throws {
        let service = MockServiceSuccess()
        let viewModel = HomeViewModel(networkService: service)
        let loadingExpectation = XCTestExpectation(description: "loadingExpectation")
        let loadedExpectation = XCTestExpectation(description: "loadedExpectation")
        
        XCTAssertEqual(viewModel.state.value, .initial)
        XCTAssertEqual(viewModel.getItemsCount(section: .categories), 0)
        XCTAssertEqual(viewModel.getItemsCount(section: .weeklySelection), 0)
        XCTAssertEqual(viewModel.getItemsCount(section: .topProducts), 0)
        XCTAssertEqual(viewModel.getItemsCount(section: .ads), 0)
        viewModel.fetchHome()
        viewModel.state.sink { state in
            switch state {
                
            case .initial:
                break
            case .loading:
                loadingExpectation.fulfill()
            case .failed(_):
                XCTFail()
            case .loaded:
                XCTAssertEqual(viewModel.getItemsCount(section: .categories), 8)
                XCTAssertEqual(viewModel.getItemsCount(section: .weeklySelection), 4)
                XCTAssertEqual(viewModel.getItemsCount(section: .topProducts), 4)
                XCTAssertEqual(viewModel.getItemsCount(section: .ads), 1)
                loadedExpectation.fulfill()
                
            }
            
        }
        .store(in: &cancellabels)
        wait(for: [loadingExpectation, loadedExpectation], timeout: 10)
    }
    
    func testGetHomeFailure() throws {
        let service = MockServiceSuccess(success: false)
        let viewModel = HomeViewModel(networkService: service)
        let loadingExpectation = XCTestExpectation(description: "loadingExpectation")
        let FailureExpectation = XCTestExpectation(description: "FailureExpectation")
        
        XCTAssertEqual(viewModel.state.value, .initial)
        
        viewModel.fetchHome()
        viewModel.state.sink { state in
            switch state {
                
            case .initial:
                break
            case .loading:
                loadingExpectation.fulfill()
            case .failed:
                FailureExpectation.fulfill()
            case .loaded:
                XCTFail()
                
            }
            
        }
        .store(in: &cancellabels)
        wait(for: [FailureExpectation, loadingExpectation], timeout: 10)
    }
}

extension HomeViewModelTests {
    
    func MockServiceSuccess(success: Bool = true) -> NetworkServiceProtocol {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        var urlSession = URLSession(configuration: configuration)
        
        let service = NetworkService(urlSession: urlSession)
        if let path = Bundle.main.path(forResource: success ? "GetHomeSuccess" : "GetHomeSuccess_Parsing_Failure", ofType: "json"), let mockData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
            MockURLProtocol.requestHandler = { request in
                return (HTTPURLResponse(), mockData)
            }
        }
        return service
    }
}
