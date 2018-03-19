//
//  FilterListInteractor.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol FilterListInteractorProtocol {
    func getFilterList(completion: @escaping NetworkCompletionHandler<[String: [Filter]]>)
}

class FilterListInteractor: FilterListInteractorProtocol {
    
    var todoistModule: TodoistModuleProtocol!
    
    init(todoistModule: TodoistModuleProtocol) {
        self.todoistModule = todoistModule
    }
    
    func getFilterList(completion: @escaping (NetworkResult<[String : [Filter]]>) -> Void) {
        
        var filterList: [String: [Filter]] = [:]
        
        let dispatchGroup: DispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        todoistModule.getAllProjects { (result) in
            var projectFilters: [Filter] = []
            switch result{
            case .success(let projects):
                for project in projects {
                    // The default option is everything selected
                    projectFilters.append(Filter(id: project.id, name: project.name, selected: true))
                }
            case .error: ()
                completion(.error)
            }
            
            filterList["Projects"] = projectFilters
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        todoistModule.getAllLabels { (result) in
            var labelFilters: [Filter] = []
            switch result{
            case .success(let labels):
                for label in labels {
                    // The default option is everything selected
                    labelFilters.append(Filter(id: label.id, name: label.name, selected: true))
                }
            case .error: ()
                completion(.error)
            }
            
            filterList["Labels"] = labelFilters
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(filterList))
        }
        
    }
    
    
}
