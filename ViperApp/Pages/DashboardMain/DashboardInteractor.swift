//
//  DashboardInteractor.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol DashboardInteractorProtocol {
    func getTasks(completion: @escaping NetworkCompletionHandler<[String]>)
}

class DashboardInteractor: DashboardInteractorProtocol {
    
    var tdModule: TodoistModuleProtocol!
    
    init(todoistModule: TodoistModuleProtocol) {
        self.tdModule = todoistModule
    }
    
    func getTasks(completion: @escaping NetworkCompletionHandler<[String]>) {
        tdModule.getAllTasks() { (result) in
            switch result{
            case .success(let tdTasks):
                var tasks: [String] = [String]()
                for tdTask in tdTasks {
                    if !tdTask.completed {
                        tasks.append(tdTask.content)
                    }
                }
                completion(.success(tasks))
            case .error:
                completion(.error)
            }
        }
    }
}
