//
//  TodoistService.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class TDProjects: Mappable {
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

class TodoistSyncService {
    
    private var token: String!
    let BASE_URI = "https://beta.todoist.com/API/v8"
    
    init(token: String) {
        self.token = token
    }
    
    func getAllProjects(success: @escaping (_ result: [TDProjects]) -> Void){
        
        let headers = [
            "Authorization": "Bearer \(token!)"
        ]
        
        let myRequest = Alamofire.request(BASE_URI+"/projects", headers: headers).responseArray { (response: DataResponse<[TDProjects]>) in
            
            guard let projects = response.result.value else {
                debugPrint("Unable to fetch Projects - Serialization Error")
                return
            }
            
            success(projects)
            
            
        }
        debugPrint(myRequest)
        
    }
    
}
