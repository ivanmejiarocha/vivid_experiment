//
//  VividAppTests.swift
//  VividAppTests
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import XCTest
@testable import VividApp

class VividAppTests: XCTestCase {

    var service: VividSeatsService!
    var mockService: MockVividSeatsService!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = VividSeatsService()
        mockService = MockVividSeatsService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadCards() {
        service.loadCards { (cards, error) in
            XCTAssert(error == nil)
            XCTAssert((cards?.count)! > 0)
        }
    }

    func testInvalidFormatException() {
        mockService.loadCards { (cards, error) in
            XCTAssert(error != nil)
            if let e = error {
                print("error: \(e.localizedDescription)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
