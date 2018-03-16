//
//  TodoistServiceTests.swift
//  ViperAppTests
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import XCTest
import Mockingjay
@testable import ViperApp

class TDRESTServiceTest: XCTestCase {
    
    let MOCK_PROJECTS_JSON =
        [
            [
                "id": "177723366",
                "name": "Inbox",
                "order": 0,
                "indent": 1,
                "comment_count": 0
            ],
            [
                "id": "177723369",
                "name": "Work",
                "order": 1,
                "indent": 1,
                "comment_count": 0
            ],
            [
                "id": "178149702",
                "name": "University",
                "order": 2,
                "indent": 1,
                "comment_count": 0
            ],
            [
                "id": "2160755645",
                "name": "SeniorProject",
                "order": 4,
                "indent": 2,
                "comment_count": 0
            ]
        ]
    
    // This is an Implicitly Unwrapped Optionals.
    // The Todolist Service which we will initialzed in setUp()
    var tdService: TDRESTServiceProtocol!
    
    // ============================================
    // MARK: - SetUp and TearDown
    // ============================================
    // These methods are called before the invocation of each test method in the class.
    
    override func setUp() {
        super.setUp()
        tdService = TDRESTService(token: "testtokenABCDEFG");
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // ============================================
    // MARK: - Test Cases
    // ============================================
    
    func testGetAllProjects() {
        stub(uri(TodolistAPI.projects.url), json(MOCK_PROJECTS_JSON))
        
        let expectation = XCTestExpectation(description: "Expect funtion to return a list of TDProjects")
        
        var expectedResult = [TDProject]()
        expectedResult.append(TDProject.init(id: "177723366", name: "Inbox", indent: 1, order: 0))
        expectedResult.append(TDProject.init(id: "177723369", name: "Work", indent: 1, order: 1))
        expectedResult.append(TDProject.init(id: "178149702", name: "University", indent: 1, order: 2))
        expectedResult.append(TDProject.init(id: "2160755645", name: "SeniorProject", indent: 2, order: 4))
        
        
        tdService.getAllProjects(nil) { projects in
            XCTAssert(expectedResult == projects)
            expectation.fulfill()
        }
        
        // wait for Async task, since we stub the request, timeout can be low
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAllLabels() {
        
    }
    
    func testGetTasks() {
        
    }
    
}
