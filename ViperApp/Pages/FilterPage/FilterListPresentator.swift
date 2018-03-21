//
//  FilterListPresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

class FilterListPresentator: FilterListViewOutput, FilterListRouterOutput, FilterListInteractorOutput {
    
    weak var view: FilterListViewInput!
    var interactor: FilterListInteractorProtocol!
    var router: FilterListRouterProtocol!
    var currentSegment: FilterType = .Project
    
    func onDoneTapped() {
        if let filters = interactor.localFiltersList {
            router.dismiss(returning: filters)
        } else {
            router.dismiss(returning: [])
        }
    }
    
    func viewDidLoad() {
        reloadView()
    }
    
    private func reloadView() {
        interactor.getFilterList(type: currentSegment) { (result) in
            switch result {
            case .error:
                () // TODO: show alert
            case .success(let filters):
                self.view.showFilters(filters: filters)
            }
        }
    }
    
    func onSegmentChange(to page: FilterType) {
        currentSegment = page
        reloadView()
    }
    
}
