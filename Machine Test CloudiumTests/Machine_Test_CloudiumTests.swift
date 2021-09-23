//
//  Machine_Test_CloudiumTests.swift
//  Machine Test CloudiumTests
//
//  Created by Deepu Stanly on 23/09/21.
//

@testable import Machine_Test_Cloudium
import XCTest

class Machine_Test_CloudiumTests: XCTestCase {

    let model = HomeViewModel()
    var didFetchResultsCalled = false
    var didFailFetchCalled = false
    
    override func setUp() {
        model.delegate = self
    }
    
    func test() {
        XCTAssertEqual(model.title, "NY Times Most Popular")
        XCTAssertEqual(model.cellName, "NewsTableViewCell")
        XCTAssertEqual(model.reuseIdentifier, "NewsCellVC")
        XCTAssertEqual(model.segue, "NewsDetailsVC")
    }
    
    func testSuccess() {
        let dummyPhoto = Photo(url: "urlstring", height: 1, width: 1)
        let dummyNews =  News(id: 1, title: "test", url: "test", author: "test", abstract: "test", updatedDate: "2021-09-20 08:11:43", media: [Media(photos: [dummyPhoto])], section: "test")
        model.fetchSucessfull(news: [dummyNews])
        XCTAssertEqual("2021-09-20", dummyNews.date)
        XCTAssertTrue(didFetchResultsCalled)
        XCTAssertEqual(model.numberOfRows, 1)
    }
    
    func testFailure() {
        model.failedFetch(message: "")
        XCTAssertTrue(didFailFetchCalled)
    }
    
}

extension Machine_Test_CloudiumTests: HomeViewModelDelegate {
    
    func didFetchResults() {
        didFetchResultsCalled = true
    }
    
    func didFailFetch(message: String) {
        didFailFetchCalled = true
    }
    
}
