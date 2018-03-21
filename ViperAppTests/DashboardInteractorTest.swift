//
//  DashboardInteractorTest.swift
//  ViperAppTests
//
//  Created by Romson Preechawit on 22/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import XCTest
@testable import ViperApp

class DashboardInteractorTest: XCTestCase {
    
    class TDServiceStub: TDService {
        
        var theExpectation: XCTestExpectation!
        
        init(theExpectation: XCTestExpectation) {
            super.init()
            self.theExpectation = theExpectation
        }
    }
    
    class TDServiceStub1: TDServiceStub {
        override func clearLoginData() {
            theExpectation.fulfill()
        }
    }
    
    func testClearLoginData() {
        let myExpectation = XCTestExpectation(description: "UserDefaults.blankDefaultsWhile expectation")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        UserDefaults.blankDefaultsWhile {
            let tdServiceStub = TDServiceStub1(theExpectation: myExpectation)
            let dashboardInteractor = DashboardInteractor(tdService: tdServiceStub)
            
            // expect clearUserCredential to call TDServiceProtocol.clearLoginData()
            dashboardInteractor.clearUserCredential()
        }
        
        wait(for: [myExpectation], timeout: 2)
        
    }
    
    class TDServiceStub2: TDServiceStub {
        override func getTasks(withFilter filters: TDFilter?, completion: @escaping (NetworkResult<[TDTask]>) -> Void) {
            // expect a nil filter
            XCTAssertNil(filters)
            
            let mockDate = Date(timeIntervalSince1970: 1521657287)
            let mockDate2 = Date(timeIntervalSince1970: 1522281600)
            let mockDue = TDDue(date: mockDate, datetime: nil, recurring: false, string: "21 Mar", timezone: nil)
            let mockDue2 = TDDue(date: mockDate2, datetime: nil, recurring: false, string: "23 Mar", timezone: nil)
            
            let tasks: [TDTask] = [
                TDTask(id: 114, completed: false, content: "testtask1", due: mockDue, indent: 1, order: 0, priority: 0, project_id: 115, label_ids: [], url: ""),
                TDTask(id: 115, completed: false, content: "testtask2", due: mockDue, indent: 1, order: 0, priority: 0, project_id: 115, label_ids: [], url: ""),
                TDTask(id: 116, completed: false, content: "testtask3", due: mockDue2, indent: 1, order: 0, priority: 0, project_id: 115, label_ids: [], url: ""),
                TDTask(id: 117, completed: true, content: "testtask4", due: mockDue, indent: 1, order: 0, priority: 0, project_id: 115, label_ids: [], url: ""),
                
            ]
            
            completion(.success(tasks))
        }
    }
    
    func testGetTasks() {
        let myExpectation = XCTestExpectation(description: "getTasks expectation")
        let tdServiceStub = TDServiceStub2(theExpectation: myExpectation)
        let dashboardInteractor = DashboardInteractor(tdService: tdServiceStub)
        
        dashboardInteractor.getTasks(withFilters: nil) { (result) in
            switch result {
            case .error:
                XCTFail()
            case .success(let tasks):
                // expect this to return tasks in 2 dates
                assert(tasks.count == 2)
                
                // Note that the mockDate give above do have time in them.
                // We do expect the interactor to remove this at taskList
                // generation for us.
                let mockDateWithoutTime = Date(timeIntervalSince1970: 1521651600)
                
                guard let firstDateTasks = tasks[mockDateWithoutTime] else {
                    XCTFail()
                    return
                }
                
                // There should be two tasks here.
                // "testtask4" should not be included as completed is marked true.
                // The interactor should ignore any completed task.
                assert(firstDateTasks.count == 2)
                
                // We know for a fact that this is at index 0 since our stub
                // return the array in this order.
                // We may want to change this to disregard the order though as
                // that is not part of the definition of "Working Correctly" for
                // this use case.w
                XCTAssertEqual(firstDateTasks[0], "testtask1")
                
                // We could take this further and test for equality of all tasks as well.
                
                myExpectation.fulfill()
            }
        }
        
        wait(for: [myExpectation], timeout: 2)
    }
    
}

