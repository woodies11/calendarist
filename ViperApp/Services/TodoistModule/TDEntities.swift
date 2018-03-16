//
//  TDEntities.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import ObjectMapper

class TDProject: Mappable {
    var id: String!
    var name: String!
    var indent: Int!
    var order: Int!
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        indent <- map["indent"]
        order <- map["order"]
    }
}
