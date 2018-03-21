//
//  FilterListInteractor.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation



protocol FilterListInteractorProtocol {
    func getFilterList(type: FilterType, completion: @escaping NetworkCompletionHandler<[Filter]>)
    var localFiltersList: [Filter]? { get }
}

class FilterListInteractor: FilterListInteractorProtocol {
    
    var localFiltersList: [Filter]?
    
    var tdService: TDServiceProtocol!
    
    // TODO: Find a better way to do Dependency Injection
    init(initial filters: [Filter]?, tdService: TDServiceProtocol) {
        self.localFiltersList = filters
        self.tdService = tdService
    }
    
    /// A utility function to filter out only Filters of certain type.
    /// Because we store all type of Filter together in one list,
    /// use this to generate a list containing only the requested FilterType.
    private class func filterListBy(filterType type: FilterType, list: [Filter]) -> [Filter] {
        var tmpList: [Filter] = []
        for filter in list {
            if filter.filterType == type {
                tmpList.append(filter)
            }
        }
        return tmpList
    }
    
    func getFilterList(type: FilterType, completion: @escaping (NetworkResult<[Filter]>) -> Void) {
        
        // If already fetched, return locally stored data.
        // TODO: This has no "cache time policy" at all
        // so if the user never leave this app and come back,
        // The list may never be updated! -> not much of a
        // concern at this point as we don't expect many people,
        // if any, to do something like that. Will add if have
        // time.
        if let localFiltersList = self.localFiltersList {
            let list = FilterListInteractor.filterListBy(filterType: type, list: localFiltersList)
            completion(.success(list))
            return
        }
        
        // Prevent multiple thread trying to access the filterList
        // at the same time, thereby fetching them from the network
        // many time and overwrite each other.
        // --------
        // We rely on the list being a list of Mutable Reference type
        // to keep the selection state. If the list is overwritten,
        // we will loss all of the current user selected state!
        DispatchQueue.main.async {
            // If data loaded while waiting for the previous queue,
            // return the data right away.
            if let localFiltersList = self.localFiltersList {
                let list = FilterListInteractor.filterListBy(filterType: type, list: localFiltersList)
                completion(.success(list))
                return
            }
        
            // We want to fetch both labels and projects
            // at the same time so there is no delay when
            // switching page.
            
            // Since we merge both type of filters into
            // one list when storing, we need both network
            // request to finish before setting our local
            // filter list.
            let dispatchGroup = DispatchGroup()
            var tmpFilterList: [Filter] = []
            
            dispatchGroup.enter()
            self.tdService.getAllProjects { (result) in
                var projectFilters: [Filter] = []
                switch result{
                case .success(let projects):
                    for project in projects {
                        // The default option is everything selected
                        projectFilters.append(Filter(id: project.id, name: project.name, selected: true, type: .Project))
                    }
                case .error: ()
                completion(.error)
                }
                
                // If this is the requested type, simply
                // return it to the presentor first so
                // it can display the list while we
                // wait for the other one.
                if type == .Project {
                    completion(.success(projectFilters))
                }
                
                // Append the list of projects to our tmp
                // and tell dispatchGroup that this block
                // is completed.
                tmpFilterList += projectFilters
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.tdService.getAllLabels { (result) in
                var labelFilters: [Filter] = []
                switch result{
                case .success(let labels):
                    for label in labels {
                        // The default option is every label NOT selected
                        labelFilters.append(Filter(id: label.id, name: label.name, selected: false, type: .Label))
                    }
                case .error: ()
                completion(.error)
                }
                
                
                // If this is the requested type, simply
                // return it to the presentor first so
                // it can display the list while we
                // wait for the other one.
                if type == .Label {
                    completion(.success(labelFilters))
                }
                
                // Append the list of labels to our tmp
                // and tell dispatchGroup that this block
                // is completed.
                tmpFilterList += labelFilters
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                // Once both network request is finished,
                // we would already have both the list of
                // projects and the list of labels
                // in our tmpFilterList. We can then store
                // this in our localFilterList
                self.localFiltersList = tmpFilterList
            }
        }
    }
    
    
}
