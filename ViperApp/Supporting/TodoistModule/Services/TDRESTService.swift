//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

protocol TDRESTServiceProtocol {
    func getAllProjects(completion: @escaping NetworkCompletionHandler<[TDProject]>)
    func getAllLabels(completion: @escaping NetworkCompletionHandler<[TDLabel]>)
    func getTasks(withFilter filter: TDFilter?, completion: @escaping NetworkCompletionHandler<[TDTask]>)
}

class TDRESTService: TDRESTServiceProtocol {
    
    // IMPORTANT: As of SE-0054, ImplicitlyUnwrappedOptional change to complier annotation only
    // This mean that String! is allow to be treated as String but will ALWAYS be treated as String?
    // with ever available.
    // This make "token" interpolated as Optional("...") in our header which cause the request to fail.
    //
    // refer to: https://stackoverflow.com/a/39537558
    private var token: String!
    
    init(token: String) {
        self.token = token
    }
    
    func getAllProjects(completion: @escaping (NetworkResult<[TDProject]>) -> Void) {
        // Include the OAuth token4
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        // Create a network request using Alamofire.
        // We can wrap this in a NetworkService class so Alamofire can
        // be replaced if necessary. But since this app is so small,
        // we will be keeping it simple for now.
        Alamofire.request(TodolistAPI.projects.url, headers: headers).responseArray { (response: DataResponse<[TDProject]>) in
            
            guard let projects = response.value else {
                completion(.error)
                return
            }
            
            // Return the list of TDProjects
            completion(.success(projects))
        }
    }
    
    func getAllLabels(completion: @escaping (NetworkResult<[TDLabel]>) -> Void) {
        
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(TodolistAPI.labels.url, headers: headers).responseArray { (response: DataResponse<[TDLabel]>) in
            guard let dataArray = response.result.value else {
                completion(.error)
                return
            }
            completion(.success(dataArray))
        }
        
    }
    
    func getTasks(withFilter filter: TDFilter?, completion: @escaping (NetworkResult<[TDTask]>) -> Void) {
        
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        let request = Alamofire.request(TodolistAPI.tasks.url, headers: headers)
        request.responseArray { (response: DataResponse<[TDTask]>) in
            // Fetch ALL tasks from TodoistAPI
            
            guard let dataArray = response.result.value else {
                completion(.error)
                return
            }
            
            // If a filter is given, do filtering here.
            // --------------------
            // NOTE: Originally, we intended to use Todoist own API
            // to do the filtering. However, the current REST API
            // only allow querying ALL or ONE Project each time so
            // if we need multiple projects, we will have to do
            // multiple network request and do dispatchGroup, etc.
            //
            // Furthermore, the filter string option requried the user
            // to be a paid user in order to utilise.
            //
            // Also by the nature of this app, most will likely query
            // a lot of projects and only leave a few the burden of tasks
            // filtering is decided to be implemented in the FrontEnd.
            
            if let filters = filter {
                guard let project_id = filters.project_id else {
                    // If we weren't able to get list of project to show,
                    // simply show all.
                    completion(.success(dataArray))
                    return
                }
                
                let label_id = filters.label_id
                
                // Create a temporary array
                var tmpTasks: [TDTask] = []
                for task in dataArray {
                    
                    if !project_id.contains(task.project_id) {
                        // If the task is not in the list of
                        // project to show then simply skip it
                        continue
                    }
                    
                    if let label_id = label_id {
                        // If no label is selected, we will show
                        // all tasks.
                        
                        // If at least one label is selected:
                        // We will only show tasks that have the labels
                        // that the user selected. Since labels and tasks
                        // have a many-to-many relationship, we find
                        // the set intersection between the two.
                        //
                        // If the intersection is empty (count <= 0),
                        // the task has no labels which we want to show.
                        if label_id.count > 0 && label_id.intersection(task.label_ids).count <= 0 {
                            continue
                        }
                        
                    }
                    // If all else passed, we add this task to the list
                    // which we want to return.
                    tmpTasks.append(task)
                }
                completion(.success(tmpTasks))
                
            } else {
                completion(.success(dataArray))
            }
        }
        
    }
    
}
