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
        let headers = [
            "Authorization": "Bearer \(token)"
        ]
        
        Alamofire.request(TodolistAPI.projects.url, headers: headers).responseArray { (response: DataResponse<[TDProject]>) in
            guard let projects = response.result.value else {
                errorHandler?(response.error)
                return
            }
            successHandler(projects)
        }
    }
    
    func getAllLabels(_ errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDLabel]) -> Void) {
        
    }
    
    func getTasks(withFilter filters: TDFilter?, errorHandler: ErrorCompletionHandler, successHandler: @escaping ([TDTask]) -> Void) {
        
    }
    
}
