//
//  DemoTests.swift
//  DemoTests
//
//  Created by Shivam Verma on 15/09/21.
//

import XCTest

@testable import Demo

class DemoTests: XCTestCase {
    var session: URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDecoding() throws {
        let jsonData = try Data(contentsOf: URL(string: "https://itunes.apple.com/search?term=michaeljackson&entity=musicVideo")!)
        XCTAssertNoThrow(try JSONDecoder().decode(ResultResponse.self, from: jsonData))
    }

    func testValidApiCallGetsHTTPStatusCode200() throws {
        let urlString =
            "https://itunes.apple.com/search?term=michaeljackson"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = session.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
