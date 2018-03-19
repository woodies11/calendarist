//
//  FilterListPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol FilterListPresentatorDelegate {
    func onDoneTapped(returning filterList: [String: [Filter]])
}

class FilterListPresentator: FilterListPresentatorDelegate {
    
    weak var view: FilterListViewControllerProtocol!
    var interactor: FilterListInteractorProtocol!
    var router: FilterListRouterProtocol!
    
    func onDoneTapped(returning filterList: [String: [Filter]]) {
        router.dismiss(filterList: filterList)
    }
}
