//
//  FilterListRouter.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

/// A Data Transfer Object for Filters
struct Filter {
    var id: Int!
    var name: Int!
    var selected: Bool!
}

protocol FilterListRouterProtocol: RouterProtocol {
    static func createModule(filterList: [String: [Filter]]) -> UIViewController
    func dismissView()
}

class FilterListRouter: FilterListRouterProtocol {
    
    class func createModule(filterList: [String : [Filter]]) -> UIViewController {
        
        // Instantiate the NavController which we define in Main Storyboard.
        // This will also instantiate our FilterListViewController since the
        // NavController have the view as its RootViewController.
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FilterNavController")
        guard let filterListViewController = navController.childViewControllers.first as? FilterListViewController
            else {
                fatalError("Unable to get FilterListViewController!")
        }
        
        // Create and assign the needed component to our ViewController
        let presentator = FilterListPresentator()
        let interactor = FilterListInteractor()
        let router = FilterListRouter()
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = filterListViewController
        filterListViewController.presentator = presentator
        
        return filterListViewController
    }
    
    func dismissView() {
        
    }
}
