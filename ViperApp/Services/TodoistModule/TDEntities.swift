//
//  TDEntities.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import ObjectMapper

struct TDProject {
    var id: String!
    var name: String!
    var indent: Int!
    var order: Int!
}

struct TDLabel {
    var id: Int!
    var name: String!
    var order: Int!
}

struct TDDue {
    var datetime: NSDate!
    var recurring: Bool = false
    var string: String = ""
    var timezone: String!
}

struct TDTask {
    var id: Int!
    var completed: Bool = false
    var content: String!
    var due: TDDue?
    var indent: Int!
    var order: Int!
    var priority: Int!
    var project_id: Int!
    var label_ids: [Int] = [Int]()
    var url: String!
}



// ============================================
// MARK: - Mappable Implementation
// ============================================

/*
 Note:
 -----
 A struct is a value type, it is immutable
 this is why we need the mutating keyword.
 
 The function, when executed, will actually
 throw away the old struct value and replace
 the whole thing with a new value, much like
 a String.
 */

extension TDProject: Mappable {
    init?(map: Map){}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        indent <- map["indent"]
        order <- map["order"]
    }
}

extension TDLabel: Mappable {
    init?(map: Map){}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        order <- map["order"]
    }
}

extension TDDue: Mappable {
    init?(map: Map){}
    
    mutating func mapping(map: Map) {
        datetime <- map["datetime"]
        recurring <- map["recurring"]
        string <- map["string"]
        timezone <- map["timezone"]
    }
}

extension TDTask: Mappable {
    init?(map: Map){}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        completed <- map["completed"]
        content <- map["content"]
        due <- map["due"]
        indent <- map["indent"]
        order <- map["order"]
        priority <- map["priority"]
        project_id <- map["project_id"]
        label_ids <- map["label_ids"]
        url <- map["url"]
    }
}
