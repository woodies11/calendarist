//
//  FilterListRouter.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

class FilterListRouter: RWPRouter, FilterListRouterInput {
    var presentator: RWPRouterOutput!
    
    
    // Hold reference to view for Segue and other navigation function.
    weak var view: UIViewController!
    // Delegate for passing data back.
    var delegate: FilterListModuleInput?
    
    class func presentModally(targetView view: UIViewController, initial filters: [Filter]?, delegate: FilterListModuleInput?, tdService: TDServiceProtocol) {
        let filterListNavController = FilterListRouter.createModule(initial: filters, delegate: delegate, tdService: tdService)
        view.present(filterListNavController, animated: true, completion: nil)
    }
    
    class func createModule(initial filters: [Filter]?, delegate: FilterListModuleInput?, tdService: TDServiceProtocol) -> UIViewController {
        
        // Instantiate the NavController which we define in Main Storyboard.
        // This will also instantiate our FilterListViewController since the
        // NavController have the view as its RootViewController.
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FilterNavController")
        FilterListRouter.configureModule(navigationController: navController, initial: filters, delegate: delegate, tdService: tdService)
        
        return navController
    }
    
    class func configureModule(navigationController view: UIViewController, initial filters: [Filter]?, delegate: FilterListModuleInput?, tdService: TDServiceProtocol) {
        
        guard let filterListViewController = view.childViewControllers.first as? FilterListViewController
            else {
                fatalError("Unable to get FilterListViewController!")
        }
        
        // Create and assign the needed component to our ViewController
        let presentator = FilterListPresentator()
        let interactor = FilterListInteractor(initial: filters, tdService: tdService)
        let router = FilterListRouter()
        
        router.view = filterListViewController
        router.delegate = delegate
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = filterListViewController
        filterListViewController.presentator = presentator
        
    }
    
    func dismiss(returning filters: [Filter]) {
        view.dismiss(animated: true) {
            self.delegate?.onFilterListReturnWithFilterOptions(filters: filters)
        }
    }
}
