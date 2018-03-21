//
//  DashboardPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

class DashboardPresentator: DashboardRouterOutput, DashboardViewOutput, DashboardInteractorOutput {
    
    weak var view: DashboardViewInput?
    var interactor: DashboardInteractorInput!
    var router: DashboardRouterInput!
    
    // Store ID of projects and labels to filter for.
    // Will fetch all if empty.
    var projectToShow: [Int] = []
    var labelToShow: [Int] = []
    var currentFilters: [Filter]?
    
    func viewDidLoad() {
        // get (fetch if needed) tasks from Todoist
        reloadView()
    }
    
    private func reloadView() {
        interactor.getTasks(withFilters: currentFilters) { (result) in
            switch result{
            case .success(let taskList):
                self.view?.showTasks(taskList: taskList)
            case .error:
                self.view?.showAlert(title: "Oops...", message: "Cannot get tasks. Please check your Internet Connection.")
            }
        }
    }
    
    func onFilterButtonTapped() {
        // Show FilterList selection page
        // currentFilter is passed so the
        // FilterList can correctly show
        // What is currently being selected
        // If this is nil, FilterList will
        // fetech a new list.
        router.presentFilterList(initial: currentFilters)
    }
    
    func onLogoutButtonTapped() {
        interactor.clearUserCredential()
        router.navigateBackToLogin()
    }
    
    func filterUpdated(filters: [Filter]) {
        self.currentFilters = filters
        reloadView()
    }
    
}
