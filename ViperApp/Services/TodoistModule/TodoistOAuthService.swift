//
//  File.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

// : AnyObject in Swift 4 == : class in Swift 3
protocol OAuthService: AnyObject {
    func initiateOAuth(error: ((AnyObject?) -> Void)?, success: (String) -> Void)
}

class TodoistOAuthService: OAuthService {
    
    func initiateOAuth(error: ((AnyObject?) -> Void)?, success: (String) -> Void) {
        success("3bb73220404b28e6aad84f27e04d549c9c22ae35")
    }
    
    private let STATE = "AvPw8jYW44N2GsTX"
    
    init() {
        
//        // TodoistiCal OAuth
//        let oauth2settings = [
//            "client_id": "6708fc59ee7f4746a6ea4ef13f660585",
//            "client_secret": "0cee40bbdcbf4d38bf68b0ff9caaf8ac", // Todoist Client Secret
//            "state": STATE, // From Todoist: A unique and unguessable string.
//                            // It is used to protect you against cross-site request forgery attacks.
//            "authorize_uri": "https://todoist.com/oauth/authorize",
//            "token_uri": "https://todoist.com/oauth/access_token",
//            "redirect_uris": "com.rwp.tddashboard://oauth/callback",
//            "scope": "data:read", // we only need to read data
//            ]
        
        
    }
    
}
