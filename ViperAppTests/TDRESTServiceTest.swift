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
    
    // MARK: - Basic Queries
    func testGetAllProjects() {
        
        // Stub Alamofire response to /projects URL to return our test JSON
        let MOCK_PROJECTS_JSON = [
            ["id": "177723366", "name": "Inbox", "order": 0, "indent": 1, "comment_count": 0],
            ["id": "177723369", "name": "Work", "order": 1, "indent": 1, "comment_count": 0],
            ["id": "178149702", "name": "University", "order": 2, "indent": 1, "comment_count": 0],
            ["id": "2160755645", "name": "SeniorProject", "order": 4, "indent": 2, "comment_count": 0]
        ]
        
        stub(uri(TodolistAPI.projects.url), json(MOCK_PROJECTS_JSON))
        
        // Since this is an Async function, we NEED to use XCTestExpectation
        // otherwise the test will simply pass without any error!
        let expectation = XCTestExpectation(description: "Expect funtion to return a list of TDProjects")
        
        // Create a list of TDProject expected to received
        // FIXME: This may get troublesome to keep insync with the MOCK_PROJECTS_JSON above...
        var expectedResult = [TDProject]()
        expectedResult.append(TDProject.init(id: "177723366", name: "Inbox", indent: 1, order: 0))
        expectedResult.append(TDProject.init(id: "177723369", name: "Work", indent: 1, order: 1))
        expectedResult.append(TDProject.init(id: "178149702", name: "University", indent: 1, order: 2))
        expectedResult.append(TDProject.init(id: "2160755645", name: "SeniorProject", indent: 2, order: 4))
        
        // Make the function call and wait for response.
        // Note that we are not testing for Error right now so passing nil
        // for errorHandler is fine
        tdService.getAllProjects(nil) { projects in
            XCTAssert(expectedResult == projects)
            expectation.fulfill()
        }
        
        // Wait for Async task to return or timeout.
        // If the timeout occured before the task return,
        // the test will fail.
        // Since we stub the request, timeout can be low
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAllLabels() {
        // See comments for testGetAllProjects()
        
        let MOCK_LABELS_JSON = [
                ["id": 2149274543,"name": "important","order": 1],
                ["id": 2148914673,"name": "next_action","order": 2],
                ["id": 2148914711,"name": "grade_impact","order": 3],
            ]
        
        stub(uri(TodolistAPI.labels.url), json(MOCK_LABELS_JSON))
        
        let expectation = XCTestExpectation(description: "Expect funtion to return a list of TDLabel")
        
        var expectedResult = [TDLabel]()
        expectedResult.append(TDLabel(id: 2149274543, name: "important", order: 1))
        expectedResult.append(TDLabel(id: 2148914673, name: "next_action", order: 2))
        expectedResult.append(TDLabel(id: 2148914711, name: "grade_impact", order: 3))
        
        tdService.getAllLabels(nil) { labels in
            XCTAssert(expectedResult == labels)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func testGetAllTasks() {
        
        // FIXME: This code look very messy...
        // We only compare id in the current implementation of Equalable anyway.
        // So maybe we do not need all these information.
        // Or maybe we should override the Equality test to be stricter for UnitTest?
        
        let MOCK_TASKS_JSON = [
            [ "id": 2224074043, "project_id": 2168993213, "content": "Lighting to Micro", "completed": false, "label_ids": [ 439997 ], "order": 3, "indent": 1, "priority": 1, "comment_count": 0, "url": "https://todoist.com/showTask?id=2224074043" ],
            [ "id": 2449200580, "project_id": 2174439030, "content": "Make a presentation to teach the “Proactive” habit", "completed": false, "label_ids": [ 440052, 2148914683, 2148917747, 2148929667, 2148929757, 2148929765, 2148942686, 2148972829 ], "order": 42, "indent": 1, "priority": 1, "comment_count": 0, "url": "https://todoist.com/showTask?id=2449200580" ],
            [ "id": 2518603530, "project_id": 2177746104, "content": "VirtualBox", "completed": false, "order": 1, "indent": 1, "priority": 1, "comment_count": 0, "url": "https://todoist.com/showTask?id=2518603530" ]
        ]
        
        stub(uri(TodolistAPI.tasks.url), json(MOCK_TASKS_JSON))
        
        let expectation = XCTestExpectation(description: "Expect funtion to return a list of TDTask")
        
        var expectedResult = [TDTask]()
        expectedResult.append(
            TDTask(
                id: 2224074043,
                completed: false,
                content: "Lighting to Micro",
                due: nil,
                indent: 1,
                order: 3,
                priority: 1,
                project_id: 2168993213,
                label_ids: [ 439997 ],
                url: "https://todoist.com/showTask?id=2224074043"
            )
        )
        expectedResult.append(
            TDTask(
                id: 2449200580,
                completed: false,
                content: "Make a presentation to teach the “Proactive” habit",
                due: nil,
                indent: 1,
                order: 42,
                priority: 1,
                project_id: 2174439030,
                label_ids: [
                    440052,
                    2148914683,
                    2148917747,
                    2148929667,
                    2148929757,
                    2148929765,
                    2148942686,
                    2148972829
                ],
                url: "https://todoist.com/showTask?id=2449200580"
            )
        )
        expectedResult.append(
            TDTask(
                id: 2518603530,
                completed: false,
                content: "VirtualBox",
                due: nil,
                indent: 1,
                order: 1,
                priority: 1,
                project_id: 2177746104,
                label_ids: [],
                url: "https://todoist.com/showTask?id=2518603530"
            )
        )
        
        tdService.getTasks(withFilter: nil, errorHandler: nil) { tasks in
            XCTAssert(expectedResult == tasks)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
}
