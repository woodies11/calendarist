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
}

class DashboardRouter: DashboardRouterProtocol {
    
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
                // FIXME: should throw an exception or something
                return UIViewController()
        }
        
        // Create and assign the needed component to our ViewController
        let presentator = DashboardPresentator()
        let interactor = DashboardInteractor(todoistModule: todoistModule)
        let router = DashboardRouter()
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = dashboardViewController
        
        dashboardViewController.presentator = presentator
        
        // Don't forget that we do need the NavViewController
        return navController
    }
}

