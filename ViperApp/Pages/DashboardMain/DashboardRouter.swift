//
//  DashboardRouter.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//


import UIKit

class DashboardRouter: RWPRouter, DashboardRouterInput {
    
    // Hold reference to view for Segue and other navigation function.
    weak var view: UIViewController!
    var presentator: DashboardRouterOutput!
    var tdService: TDServiceProtocol!
    
    /**
     create, bind, and initialize DashboardViewController
     @return UIViewController
     */
    class func createModule(tdService: TDServiceProtocol) -> UIViewController {
        
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
        let interactor = DashboardInteractor(tdService: tdService)
        let router = DashboardRouter()
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = dashboardViewController
        
        router.view = dashboardViewController
        router.presentator = presentator
        
        // FIXME: change to a better dependency injecting
        router.tdService = tdService
        
        dashboardViewController.presentator = presentator
        
        // Don't forget that we do need the NavViewController
        return navController
    }
    
    func presentFilterList(initial filters: [Filter]?) {
        FilterListRouter.presentModally(targetView: view, initial: filters, delegate: self, tdService: self.tdService)
    }
    
    func navigateBackToLogin() {
        view.dismiss(animated: true, completion: nil)
    }
    
}

extension DashboardRouter: FilterListModuleDelegate {
    func onFilterListReturnWithFilterOptions(filters: [Filter]) {
        presentator?.filterUpdated(filters: filters)
    }
}

