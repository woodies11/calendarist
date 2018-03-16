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
    var tdService: TDRESTServiceProtocol!
    
    // ============================================
    // MARK: - SetUp and TearDown
    // ============================================
    // These methods are called before the invocation of each test method in the class.
    
    override func setUp() {
        super.setUp()
        tdService = TDRESTService("testtokenABCDEFG");
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // ============================================
    // MARK: - Test Cases
    // ============================================
    
    func testGetAllProjects() {
        let projects = tdService.getAllProjects()
        XCTAssertEqual(projects, ["a", "b", "c", "d"])
    }
    
}
