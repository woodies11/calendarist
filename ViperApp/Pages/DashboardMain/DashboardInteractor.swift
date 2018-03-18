//
//  DashboardInteractor.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import SwiftDate

protocol DashboardInteractorProtocol {
    func getTasks(completion: @escaping NetworkCompletionHandler<[Date: [String]]>)
}

class DashboardInteractor: DashboardInteractorProtocol {
    
    var tdModule: TodoistModuleProtocol!
    
    init(todoistModule: TodoistModuleProtocol) {
        self.tdModule = todoistModule
    }
    
    func getTasks(completion: @escaping NetworkCompletionHandler<[Date: [String]]>) {
        tdModule.getAllTasks() { (result) in
            switch result{
            case .success(let tdTasks):
                var taskList: [Date: [String]] = [:]
                for tdTask in tdTasks {
                    if tdTask.completed { continue }
                    guard let dueDateTime = tdTask.due else { continue }
                    
                    let dueDateIgnoreTime = dueDateTime.date.startOfDay
                    if taskList[dueDateIgnoreTime] == nil {
                        taskList[dueDateIgnoreTime] = [String]()
                    }
                    
                    taskList[dueDateIgnoreTime]!.append(tdTask.content)
                }
                completion(.success(taskList))
            case .error:
                completion(.error)
            }
        }
    }
}
