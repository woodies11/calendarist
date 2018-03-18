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
    
    func viewDidLoad() {
        interactor.getTasks { (result) in
            switch result{
            case .success(let tasks):
                self.view.taskList = tasks
            case .error:
                self.view.showAlert(title: "Network Error!", message: "Cannot get tasks.")
            }
        }
    }
}
