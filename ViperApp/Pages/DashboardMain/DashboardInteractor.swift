//
//  DashboardInteractor.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import SwiftDate

class DashboardInteractor: DashboardInteractorInput {
    
    var tdService: TDServiceProtocol!
    
    init(tdService: TDServiceProtocol) {
        self.tdService = tdService
    }
    
    func getTasks(withFilters filters: [Filter]?, completion: @escaping NetworkCompletionHandler<[Date: [String]]>) {
        
        let tdFilter: TDFilter? = DashboardInteractor.toTDFilter(filters)
        
        tdService.getTasks(withFilter: tdFilter) { (result) in
            switch result{
            case .success(let tdTasks):
                let taskList = self.generateTaskList(tdTasks)
                completion(.success(taskList))
            case .error:
                completion(.error)
            }
        }
    }
    
    func clearUserCredential() {
        tdService.clearLoginData()
    }
    
    // ====================================================================================
    // MARK - Utility Functions
    // ====================================================================================
    
    /// Convert our [TDTask] entity to a POSDS (Plain Old Swift Data Structure)
    private func generateTaskList(_ tdTasks: [TDTask]) -> [Date: [String]] {
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
        return taskList
    }
    
    /// Convert our POSO (Plain Old Swift Object) Filter into
    /// TDFilter entity which is used by TDService
    private static func toTDFilter(_ filters: [Filter]?) -> TDFilter? {
        var tdFilter: TDFilter? = nil
        
        if let filters = filters {
            
            var project_id: Set<Int> = []
            var label_id: Set<Int> = []
            
            for filter in filters {
                if !filter.selected { continue }
                
                switch filter.filterType! {
                case .Label:
                    label_id.insert(filter.id)
                case .Project:
                    project_id.insert(filter.id)
                }
                
                tdFilter = TDFilter(project_id: project_id, label_id: label_id, filter: nil, lang: nil)
                
                
            }
        }
        
        return tdFilter
    }
}
