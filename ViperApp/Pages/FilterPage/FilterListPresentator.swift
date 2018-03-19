//
//  FilterListPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol FilterListPresentatorDelegate {
    func viewDidLoad()
    func onDoneTapped(returning filterList: [String: [Filter]])
}

class FilterListPresentator: FilterListPresentatorDelegate {
    
    weak var view: FilterListViewControllerProtocol!
    var interactor: FilterListInteractorProtocol!
    var router: FilterListRouterProtocol!
    
    func onDoneTapped(returning filterList: [String: [Filter]]) {
        router.dismiss(returning: filterList)
    }
    
    func viewDidLoad() {
        interactor.getFilterList { (result) in
            switch result {
            case .error:
                () // TODO: show alert
            case .success(let filterList):
                self.view.filterList = filterList
                self.view.reloadView()
            }
        }
    }
}
