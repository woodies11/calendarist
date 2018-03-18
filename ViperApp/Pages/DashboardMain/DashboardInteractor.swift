//
//  DashboardInteractor.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol DashboardInteractorProtocol {
    func getTasks()
}

class DashboardInteractor {
    
    var todoistModule: TodoistModuleProtocol!
    
    func getTasks() {
        
    }
}
