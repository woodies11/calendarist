//
//  DashboardRouter.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//


import UIKit

protocol DashboardRouterProtocol: RouterProtocol {
    static func createModule() -> UIViewController
}

class DashboardRouter: DashboardRouterProtocol {
    
    /**
     create, bind, and initialize DashboardViewController
     @return UIViewController
     */
    class func createModule() -> UIViewController {
        
        // Instantiate the NavController which we define in Main Storyboard.
        // This will also instantiate our DashboardViewController since the
        // NavController have the view as its RootViewController.
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNavViewController")
        guard let dashboardViewController = navController.childViewControllers.first as? DashboardViewController
            else {
                // TODO: throw an exception or something
                return UIViewController()
        }
        
        // Create and assign the presentator to our ViewController
        let presentator = DashboardPresentator()
        dashboardViewController.presentator = presentator
        
        return dashboardViewController
    }
}

