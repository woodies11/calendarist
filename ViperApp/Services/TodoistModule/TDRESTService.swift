//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias ErrorCompletionHandler = ((_ error: Error?) -> Void)?

protocol TDRESTServiceProtocol {
    func getAllProjects(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDProject]) -> Void)
    func getAllLabels(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDLabel]) -> Void)
    func getTasks(withFilter filters: TDFilter?, errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDTask]) -> Void)
}

class TDRESTService: TDRESTServiceProtocol {
    private var token: String!
    
    init(token: String) {
        self.token = token
    }
    
    func getAllProjects(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDProject]) -> Void) {
        // Include the OAuth token
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        // Create a network request using Alamofire.
        // We can wrap this in a NetworkService class so Alamofire can
        // be replaced if necessary. But since this app is so small,
        // we will be keeping it simple for now.
        Alamofire.request(TodolistAPI.projects.url, headers: headers).responseArray { (response: DataResponse<[TDProject]>) in
            
            // TODO: May need to look at other possible sign of error
            
            guard let projects = response.result.value else {
                errorHandler?(response.error)
                return
            }
            
            // Return the list of TDProjects
            successHandler(projects)
        }
    }
    
    func getAllLabels(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDLabel]) -> Void) {
        
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        Alamofire.request(TodolistAPI.labels.url, headers: headers).responseArray { (response: DataResponse<[TDLabel]>) in
            guard let dataArray = response.result.value else {
                errorHandler?(response.error)
                return
            }
            successHandler(dataArray)
        }
        
    }
    
    func getTasks(withFilter filters: TDFilter?, errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDTask]) -> Void) {
        
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        Alamofire.request(TodolistAPI.tasks.url, headers: headers).responseArray { (response: DataResponse<[TDTask]>) in
            guard let dataArray = response.result.value else {
                errorHandler?(response.error)
                return
            }
            successHandler(dataArray)
        }
        
    }
    
}
