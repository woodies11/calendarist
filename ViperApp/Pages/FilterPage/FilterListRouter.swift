//
//  FilterListRouter.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

/// A Plain Old Swift Object
/// Data Transfer Object for Filters.
struct Filter {
    var id: Int!
    var name: Int!
    var selected: Bool!
}

protocol FilterListRouterProtocol: RouterProtocol {
    static func createModule(filterList: [String: [Filter]], delegate: FilterListModuleDelegate?) -> UIViewController
    static func configureModule(navigationController view: UIViewController, filterList: [String: [Filter]], delegate: FilterListModuleDelegate?)
    static func presentModally(targetView view: UIViewController, filterList: [String: [Filter]], delegate: FilterListModuleDelegate?)
    func dismiss(filterList: [String: [Filter]])
}

protocol FilterListModuleDelegate {
    func onFilterListReturnWithFilterOptions(filterList: [String: [Filter]])
}

class FilterListRouter: FilterListRouterProtocol {
    
    // Hold reference to view for Segue and other navigation function.
    weak var view: UIViewController!
    // Delegate for passing data back.
    var delegate: FilterListModuleDelegate?
    
    class func presentModally(targetView view: UIViewController, filterList: [String : [Filter]], delegate: FilterListModuleDelegate?) {
        let filterListNavController = FilterListRouter.createModule(filterList: filterList, delegate: delegate)
        view.present(filterListNavController, animated: true, completion: nil)
    }
    
    class func createModule(filterList: [String : [Filter]], delegate: FilterListModuleDelegate?) -> UIViewController {
        
        // Instantiate the NavController which we define in Main Storyboard.
        // This will also instantiate our FilterListViewController since the
        // NavController have the view as its RootViewController.
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FilterNavController")
        FilterListRouter.configureModule(navigationController: navController, filterList: filterList, delegate: delegate)
        
        return navController
    }
    
    class func configureModule(navigationController view: UIViewController, filterList: [String: [Filter]], delegate: FilterListModuleDelegate?) {
        
        guard let filterListViewController = view.childViewControllers.first as? FilterListViewController
            else {
                fatalError("Unable to get FilterListViewController!")
        }
        
        filterListViewController.filterList = filterList
        
        // Create and assign the needed component to our ViewController
        let presentator = FilterListPresentator()
        let interactor = FilterListInteractor()
        let router = FilterListRouter()
        
        router.view = filterListViewController
        router.delegate = delegate
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = filterListViewController
        filterListViewController.presentator = presentator
        
    }
    
    func dismiss(filterList: [String : [Filter]]) {
        view.dismiss(animated: true) {
            self.delegate?.onFilterListReturnWithFilterOptions(filterList: filterList)
        }
    }
}
