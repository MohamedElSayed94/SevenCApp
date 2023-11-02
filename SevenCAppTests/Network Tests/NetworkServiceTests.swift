//
//  NetworkServiceTests.swift
//  GiphyPicnicTests
//
//  Created by MohamedSaidZC on 03/11/2023.
//

import XCTest
import Combine

@testable import SevenCApp

final class NetworkServiceTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!
    var cancellabels = [AnyCancellable]()
    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testGetRandomGifSuccess() throws {
        // NetworkService. Injected with custom url session for mocking
        let networkService = NetworkService(urlSession: urlSession)
        
        // Set mock data
        
        guard let path = Bundle.main.path(forResource: "GetHomeSuccess", ofType: "json") else {
            XCTFail()
            return
        }
        let mockData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        networkService.request(GetHomeEndPoint()).sink(receiveCompletion: {completion in
            switch completion {
            case .failure:
                XCTFail()
            case .finished:
                expectation.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertEqual(response.data.categories.count, 8)
            XCTAssertEqual(response.data.weeklyProducts.count, 4)
            XCTAssertEqual(response.data.topProducts.count, 4)
            XCTAssertEqual(response.data.ads.count, 1)
            XCTAssertEqual(response.data.slider.count, 3)
            expectation.fulfill()
        })
        .store(in: &cancellabels)
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRandomGifFailureBadResponse() throws {
        // NetworkService. Injected with custom url session for mocking
        let networkService = NetworkService(urlSession: urlSession)
        let url = "www.test.com"
        let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 300, httpVersion: nil, headerFields: nil)!
//         Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (response, Data())
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        

        networkService.request(GetHomeEndPoint()).sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, APIError.badResponse(statusCode: 300))
                expectation.fulfill()
                
            case .finished:
                XCTFail()
            }
        }, receiveValue: { _ in })
            .store(in: &cancellabels)
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRandomGifParsingError() throws {
        // NetworkService. Injected with custom url session for mocking
        let networkService = NetworkService(urlSession: urlSession)
        let url = "www.test.com"
        let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        guard let path = Bundle.main.path(forResource: "GetHomeSuccess_Parsing_Failure", ofType: "json") else {
            XCTFail()
            return
        }
        let mockUnexpectedFormatData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        
//         Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (response, mockUnexpectedFormatData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        networkService.request(GetHomeEndPoint()).sink(receiveCompletion: {completion in
            switch completion {
            case .failure(let error):
                
                if case APIError.parsing = error {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            case .finished:
                XCTFail()
            }
        }, receiveValue: { _ in })
            .store(in: &cancellabels)
        wait(for: [expectation], timeout: 10)
    }

}
