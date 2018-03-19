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
class Filter: Equatable {
    var id: Int!
    var name: String!
    var selected: Bool!
    var type: FilterType!
    
    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        return lhs.type == rhs.type && lhs.id == rhs.id
    }
    
    init(id: Int, name: String, selected: Bool, type: FilterType) {
        self.id = id
        self.name = name
        self.selected = selected
        self.type = type
    }
    
}

enum FilterType: Int {
    case Project = 0
    case Label = 1
}

protocol FilterListRouterProtocol: RouterProtocol {
    static func createModule(initial filterList: [String: [Filter]]?, delegate: FilterListModuleDelegate?, todoistModule: TodoistModuleProtocol) -> UIViewController
    static func configureModule(navigationController view: UIViewController, initial filterList: [String: [Filter]]?, delegate: FilterListModuleDelegate?, todoistModule: TodoistModuleProtocol)
    static func presentModally(targetView view: UIViewController, initial filterList: [String: [Filter]]?, delegate: FilterListModuleDelegate?, todoistModule: TodoistModuleProtocol)
    func dismiss(returning filters: [Filter])
}

protocol FilterListModuleDelegate {
    func onFilterListReturnWithFilterOptions(filters: [Filter])
}

class FilterListRouter: FilterListRouterProtocol {
    
    // Hold reference to view for Segue and other navigation function.
    weak var view: UIViewController!
    // Delegate for passing data back.
    var delegate: FilterListModuleDelegate?
    
    class func presentModally(targetView view: UIViewController, initial filterList: [String : [Filter]]?, delegate: FilterListModuleDelegate?, todoistModule: TodoistModuleProtocol) {
        let filterListNavController = FilterListRouter.createModule(initial: filterList, delegate: delegate, todoistModule: todoistModule)
        view.present(filterListNavController, animated: true, completion: nil)
    }
    
    class func createModule(initial filterList: [String : [Filter]]?, delegate: FilterListModuleDelegate?, todoistModule: TodoistModuleProtocol) -> UIViewController {
        
        // Instantiate the NavController which we define in Main Storyboard.
        // This will also instantiate our FilterListViewController since the
        // NavController have the view as its RootViewController.
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FilterNavController")
        FilterListRouter.configureModule(navigationController: navController, initial: filterList, delegate: delegate, todoistModule: todoistModule)
        
        return navController
    }
    
    class func configureModule(navigationController view: UIViewController, initial filterList: [String: [Filter]]?, delegate: FilterListModuleDelegate?, todoistModule: TodoistModuleProtocol) {
        
        guard let filterListViewController = view.childViewControllers.first as? FilterListViewController
            else {
                fatalError("Unable to get FilterListViewController!")
        }
        
        // Create and assign the needed component to our ViewController
        let presentator = FilterListPresentator()
        let interactor = FilterListInteractor(todoistModule: todoistModule)
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
