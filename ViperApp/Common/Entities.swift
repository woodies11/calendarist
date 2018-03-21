//
//  Task.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

struct Task {
    let content: String!
    let due: NSDate!
}

struct Project {
    let name: String!
}

struct Label {
    let name: String!
}

/// A Plain Old Swift Object
/// Data Transfer Object for Filters.
class Filter: Equatable {
    var id: Int!
    var name: String!
    var selected: Bool!
    var filterType: FilterType!
    
    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        return lhs.filterType == rhs.filterType && lhs.id == rhs.id
    }
    
    init(id: Int, name: String, selected: Bool, type: FilterType) {
        self.id = id
        self.name = name
        self.selected = selected
        self.filterType = type
    }
    
}

enum FilterType: Int {
    case Project = 0
    case Label = 1
}
