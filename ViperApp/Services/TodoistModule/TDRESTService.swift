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

typealias ErrorCompletionHandler = ((error: NSError) -> Void)?

protocol TDRestServiceProtocol {
    func getAllProjects(@escaping errorHandler: ErrorCompletionHandler, @escaping successHandler: (projects: [TDProject]))
    func getAllLabels(@escaping errorHandler: ErrorCompletionHandler, @escaping successHandler: (labels: [TDLabel]))
    func getTasks(withFilter filters: TDFilter?, @escaping errorHandler: ErrorCompletionHandler, @escaping successHandler: (tasks: [TDTask]))
}

class TDRESTService {
    
    private var token: String!
    
    init(token: String) {
        self.token = token
    }
    
    func getAllProjects(success: @escaping (_ result: [TDProject]) -> Void){
        
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        let myRequest = Alamofire.request(TodolistAPI.projects.url, headers: headers).responseArray { (response: DataResponse<[TDProject]>) in
            
            guard let projects = response.result.value else {
                debugPrint("Unable to fetch Projects - Serialization Error")
                return
            }
            
            success(projects)
            
            
        }
        debugPrint(myRequest)
        
    }
    
}
