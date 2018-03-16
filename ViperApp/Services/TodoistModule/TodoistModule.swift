//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

class TodoistModule {
    
    var token: String?
    
    var tdOAuthService: TodoistOAuthService!
    var tdSyncService: TodoistSyncService!
    
    // TODO: change to completion handler
    func authenticate() {
        tdOAuthService = TodoistOAuthService()
        
        // try to get token
        tdOAuthService.initiateOAuth(error: nil) { (access_token) in
            self.token = access_token
            tdSyncService = TodoistSyncService(token: token!)
        }
    }
    
    func getAllProjects(error: ((AnyObject?) -> Void)?, success: @escaping ([String]) -> Void) {
        
        if !isAuthenticated() {
            authenticate()
        }
        
        tdSyncService.getAllProjects() { (result) in
            var projects = [String]()
            for project in result {
                projects.append(project.name)
            }
            
            success(projects)
        }
    }
    
    func isAuthenticated() -> Bool {
        return token != nil
    }
    
    
    
    
}
