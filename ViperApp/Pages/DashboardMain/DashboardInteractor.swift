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
    var currentFilter: [String: [Filter]]? { get set }
    func getTasks(completion: @escaping NetworkCompletionHandler<[Date: [String]]>)
}

class DashboardInteractor: DashboardInteractorProtocol {
    
    var tdModule: TodoistModuleProtocol!
    
    // In case a filter present is currently applied,
    // we want to store it here.
    var currentFilter: [String: [Filter]]?
    
    init(todoistModule: TodoistModuleProtocol) {
        self.tdModule = todoistModule
    }
    
    func getTasks(completion: @escaping NetworkCompletionHandler<[Date: [String]]>) {
        tdModule.getAllTasks() { (result) in
            switch result{
            case .success(let tdTasks):
                let taskList = self.generateTaskList(tdTasks)
                completion(.success(taskList))
            case .error:
                completion(.error)
            }
        }
    }
    
    private func generateTaskList(_ tdTasks: [TDTask]) -> [Date: [String]] {
        var taskList: [Date: [String]] = [:]
        
        // TODO: Prepare filter here
        
        for tdTask in tdTasks {
            if tdTask.completed { continue }
            guard let dueDateTime = tdTask.due else { continue }
            
            let dueDateIgnoreTime = dueDateTime.date.startOfDay
            if taskList[dueDateIgnoreTime] == nil {
                taskList[dueDateIgnoreTime] = [String]()
            }
            
            taskList[dueDateIgnoreTime]!.append(tdTask.content)
        }
        return taskList
    }
}
