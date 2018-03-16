//
//  Endpoint.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base_url: String { get }
    var path: String { get }
    var url: String { get }
}

// Default Implementation of Endpoint url value
extension Endpoint {
    var base_url: String { return "https://beta.todoist.com/API/v8" }
    var url: String { return "\(self.base_url)\(self.path)" }
}

enum TodolistAPI: Endpoint {
    case projects
    case tasks
    case labels
    
    public var path: String {
        switch self {
        case .projects: return "/projects"
        case .tasks: return "/tasks"
        case .labels: return "/labels"
        }
    }
    
}
