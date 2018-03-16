//
//  TodoistServiceTests.swift
//  ViperAppTests
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import XCTest
@testable import ViperApp

class TDRESTServiceTest: XCTestCase {
    
    // This is an Implicitly Unwrapped Optionals.
    // The Todolist Service which we will initialzed in setUp()
    var tdService: TodoistService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tdService = TodoistService();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Test Cases
    // ==========================================================
    
    func testGetAllProjects() {
        let projects = tdService.getAllProjects()
        XCTAssertEqual(projects, ["a", "b", "c", "d"])
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
