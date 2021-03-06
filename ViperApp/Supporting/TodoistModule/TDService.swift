//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import UIKit

protocol TDServiceProtocol {
    func getTasks(withFilter filters: TDFilter?, completion: @escaping NetworkCompletionHandler<[TDTask]>)
    func getAllLabels(completion: @escaping NetworkCompletionHandler<[TDLabel]>)
    func getAllProjects(completion: @escaping NetworkCompletionHandler<[TDProject]>)
    func initiateOAuth(sourceView view: UIViewController, completion: @escaping NetworkCompletionHandler<Bool>)
    func clearLoginData()
}

class TDService: TDServiceProtocol {
    
    static let USER_DEFAULT_TOKEN_KEY = "USER_DEFAULT_TOKEN_KEY"
    
    var token: String?
    
    // FIXME: should change to protocol... but we only ever use it to get
    // the token...
    // TODO: look at separation of concerns and trade off of combining
    var tdOAuthService: TDOAuthServiceProtocol!
    var tdRESTService: TDRESTServiceProtocol!
    
    init() {
        // Try to load stored token first
        if let access_token = UserDefaults.standard.string(forKey: TDService.USER_DEFAULT_TOKEN_KEY) {
            self.token = access_token
            self.tdRESTService = TDRESTService(token: access_token)
        }
    }
    
    func clearLoginData() {
        UserDefaults.standard.removeObject(forKey: TDService.USER_DEFAULT_TOKEN_KEY)
        self.token = nil
    }
    
    // TODO: change to completion handler
    func initiateOAuth(sourceView view: UIViewController, completion: @escaping NetworkCompletionHandler<Bool>) {
        if tdOAuthService == nil {
            tdOAuthService = TDOAuthService()
        }
        
        // try to get token
        if let access_token = UserDefaults.standard.string(forKey: TDService.USER_DEFAULT_TOKEN_KEY) {
            self.token = access_token
            self.tdRESTService = TDRESTService(token: access_token)
            completion(.success(true))
            return
        }
        
        tdOAuthService.initiateOAuth(displayOAuthPageOn: view, error: nil) { (access_token) in
            UserDefaults.standard.setValue(access_token, forKey: TDService.USER_DEFAULT_TOKEN_KEY)
            self.token = access_token
            self.tdRESTService = TDRESTService(token: access_token)
            completion(.success(true))
            return
        }
    }
    
    func isAuthenticated() -> Bool {
        return token != nil
    }
    
    func getTasks(withFilter filters: TDFilter?, completion: @escaping (NetworkResult<[TDTask]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            completion(.error)
        }
        tdRESTService.getTasks(withFilter: filters, completion: completion)
        
    }
    
    func getAllLabels(completion: @escaping (NetworkResult<[TDLabel]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            completion(.error)
        }
        tdRESTService.getAllLabels(completion: completion)
    }
    
    func getAllProjects(completion: @escaping (NetworkResult<[TDProject]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            completion(.error)
        }
        tdRESTService.getAllProjects(completion: completion)
    }
    
    
}
