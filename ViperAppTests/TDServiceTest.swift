//
//  TDServiceTest.swift
//  ViperAppTests
//
//  Created by Romson Preechawit on 22/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import XCTest
@testable import ViperApp

class TDServiceTest: XCTestCase {
    
    class TDOAuthServiceStub: TDOAuthServiceProtocol {
        func initiateOAuth(displayOAuthPageOn view: UIViewController, error: ((AnyObject?) -> Void)?, success: @escaping (String) -> Void) {
            print("returned")
            success("SOMETOKEN")
        }
    }
    
    func testOAuthFlow() {
        
        let myExpectation = XCTestExpectation(description: "UserDefaults.blankDefaultsWhile expectation")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        UserDefaults.blankDefaultsWhile {
            var tdService = TDService()
            
            // Expect the tdService to not be authenticated
            // at first!
            assert(!tdService.isAuthenticated())
            
            // Create a dummy OAuth service that will always return a token
            // and inject it into our tdService.
            let oauthStub = TDOAuthServiceStub()
            tdService.tdOAuthService = oauthStub
            
            // try to authenticate
            tdService.initiateOAuth(sourceView: UIViewController(), completion: { result in
                switch result{
                case .success(_):
                    // tdService should now have a token equal to our
                    // stub token
                    assert(tdService.token! == "SOMETOKEN")
                    // and show be authenticated
                    assert(tdService.isAuthenticated())
                    // also make sure that the token is properly stored in our UserDefault
                    assert(UserDefaults.standard.string(forKey: TDService.USER_DEFAULT_TOKEN_KEY)! == "SOMETOKEN")
                    
                    // now a new tdService should use token from the UserDefault
                    tdService = TDService()
                    assert(tdService.isAuthenticated())
                    
                    // next, try to clear the token out
                    tdService.clearLoginData()
                    
                    // should no longer be authenticated
                    assert(!tdService.isAuthenticated())
                    
                    // should also clear the token out of UserDefaults
                    XCTAssertNil(UserDefaults.standard.string(forKey: TDService.USER_DEFAULT_TOKEN_KEY))
                    
                    // any new tdService should not be authenticated
                    tdService = TDService()
                    assert(!tdService.isAuthenticated())
                    
                    myExpectation.fulfill()
                    
                case .error:
                    XCTFail()
                }
            })
            
        }
        
        wait(for: [myExpectation], timeout: 2)
        
    }
    
}
