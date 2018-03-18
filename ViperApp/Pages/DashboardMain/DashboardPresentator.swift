//
//  DashboardPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol DashboardPresentatorProtocol {
    func viewDidLoad()
}

class DashboardPresentator: DashboardPresentatorProtocol {
    
    weak var view: DashboardViewController?
    var interactor: DashboardInteractorProtocol!
    var router: DashboardRouterProtocol!
    
    func viewDidLoad() {
        
    }
}
