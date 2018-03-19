//
//  DashboardRouter.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//


import UIKit

protocol DashboardRouterProtocol: RouterProtocol {
    static func createModule(todoistModule: TodoistModuleProtocol) -> UIViewController
    func presentFilterList(initial filters: [Filter]?)
}

class DashboardRouter: DashboardRouterProtocol {
    
    // Hold reference to view for Segue and other navigation function.
    weak var view: UIViewController!
    var presentator: DashboardPresentatorDelegate!
    var todoistModule: TodoistModuleProtocol!
    
    /**
     create, bind, and initialize DashboardViewController
     @return UIViewController
     */
    class func createModule(todoistModule: TodoistModuleProtocol) -> UIViewController {
        
        // Instantiate the NavController which we define in Main Storyboard.
        // This will also instantiate our DashboardViewController since the
        // NavController have the view as its RootViewController.
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNavViewController")
        guard let dashboardViewController = navController.childViewControllers.first as? DashboardViewController
            else {
                fatalError("Unable to get DashboardViewController")
        }
        
        // Create and assign the needed component in our VIPER module
        let presentator = DashboardPresentator()
        let interactor = DashboardInteractor(todoistModule: todoistModule)
        let router = DashboardRouter()
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = dashboardViewController
        
        router.view = dashboardViewController
        router.presentator = presentator
        
        // FIXME: change to a better dependency injecting
        router.todoistModule = todoistModule
        
        dashboardViewController.presentator = presentator
        
        // Don't forget that we do need the NavViewController
        return navController
    }
    
    func presentFilterList(initial filters: [Filter]?) {
        FilterListRouter.presentModally(targetView: view, initial: filters, delegate: self, todoistModule: self.todoistModule)
    }
}

extension DashboardRouter: FilterListModuleDelegate {
    func onFilterListReturnWithFilterOptions(filters: [Filter]) {
        presentator?.filterUpdated(filters: filters)
    }
}

