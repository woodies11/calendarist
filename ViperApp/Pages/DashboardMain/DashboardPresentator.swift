//
//  DashboardPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol DashboardPresentatorDelegate {
    func viewDidLoad()
}

class DashboardPresentator: DashboardPresentatorDelegate {
    
    weak var view: DashboardViewControllerProtocol!
    var interactor: DashboardInteractorProtocol!
    var router: DashboardRouterProtocol!
    
    // Store ID of projects and labels to filter for.
    // Will fetch all if empty.
    var projectToShow: [Int] = []
    var labelToShow: [Int] = []
    
    func viewDidLoad() {
        // get (fetch if needed) tasks from Todoist
        interactor.getTasks { (result) in
            switch result{
            case .success(let taskList):
                self.view.taskList = taskList
            case .error:
                self.view.showAlert(title: "Oops...", message: "Cannot get tasks.")
            }
        }
    }
    
}
