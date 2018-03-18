//
//  FilterListPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol FilterListPresentatorDelegate {
    
}

class FilterListPresentator: FilterListPresentatorDelegate {
    weak var view: FilterListViewControllerProtocol!
    var interactor: FilterListInteractorProtocol!
    var router: FilterListRouterProtocol!
}
