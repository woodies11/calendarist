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

protocol RouterProtocol {
    static var mainStoryboard: UIStoryboard { get }
}

extension RouterProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

class DashboardRouter: DashboardRouterProtocol {
    
    class func createModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNavViewController")
        guard let dashboardViewController = navController.childViewControllers.first as? DashboardViewController
            else {
                // TODO: throw an exception or something
                return UIViewController()
        }
        
        let presentator = DashboardPresentator()
        dashboardViewController.presentator = presentator
        
        return dashboardViewController
    }
}
