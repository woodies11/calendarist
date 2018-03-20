//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import UIKit

protocol TodoistModuleProtocol {
    func getTasks(withFilter filters: TDFilter?, completion: @escaping NetworkCompletionHandler<[TDTask]>)
    func getAllLabels(completion: @escaping NetworkCompletionHandler<[TDLabel]>)
    func getAllProjects(completion: @escaping NetworkCompletionHandler<[TDProject]>)
    func initiateOAuth(sourceView view: UIViewController, completion: @escaping NetworkCompletionHandler<Bool>)
}

class TodoistModule: TodoistModuleProtocol {
    
    static let USER_DEFAULT_TOKEN_KEY = "USER_DEFAULT_TOKEN_KEY"
    
    var token: String?
    
    var tdOAuthService: TDOAuthService!
    var tdSyncService: TDRESTService!
    
    init() {
        // Try to load stored token first
        if let access_token = UserDefaults.standard.string(forKey: TodoistModule.USER_DEFAULT_TOKEN_KEY) {
            self.token = access_token
            self.tdSyncService = TDRESTService(token: access_token)
        }
    }
    
    // TODO: change to completion handler
    func initiateOAuth(sourceView view: UIViewController, completion: @escaping NetworkCompletionHandler<Bool>) {
        tdOAuthService = TDOAuthService()
        
        // try to get token
        if let access_token = UserDefaults.standard.string(forKey: TodoistModule.USER_DEFAULT_TOKEN_KEY) {
            self.token = access_token
            self.tdSyncService = TDRESTService(token: access_token)
            completion(.success(true))
            return
        }
        
        tdOAuthService.initiateOAuth(displayOAuthPageOn: view, error: nil) { (access_token) in
            UserDefaults.standard.setValue(access_token, forKey: TodoistModule.USER_DEFAULT_TOKEN_KEY)
            self.token = access_token
            self.tdSyncService = TDRESTService(token: access_token)
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
        tdSyncService.getTasks(withFilter: filters, completion: completion)
        
    }
    
    func getAllLabels(completion: @escaping (NetworkResult<[TDLabel]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            completion(.error)
        }
        tdSyncService.getAllLabels(completion: completion)
    }
    
    func getAllProjects(completion: @escaping (NetworkResult<[TDProject]>) -> Void) {
        if !isAuthenticated() {
            // FIXME: should throw exception or redirect user to login page
            completion(.error)
        }
        tdSyncService.getAllProjects(completion: completion)
    }
    
    
}
