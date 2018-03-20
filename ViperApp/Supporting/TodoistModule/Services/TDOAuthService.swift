//
//  File.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import OAuthSwift

// : AnyObject in Swift 4 == : class in Swift 3
protocol OAuthService: AnyObject {
    func initiateOAuth(displayOAuthPageOn view: UIViewController, error: ((AnyObject?) -> Void)?, success: @escaping (String) -> Void)
}

class TDOAuthService: OAuthService {
    
    let oauthswift = OAuth2Swift(
        consumerKey: "6708fc59ee7f4746a6ea4ef13f660585",
        consumerSecret: "0cee40bbdcbf4d38bf68b0ff9caaf8ac",
        authorizeUrl: "https://todoist.com/oauth/authorize",
        accessTokenUrl: "https://todoist.com/oauth/access_token",
        responseType: "code"
    )
    
    func initiateOAuth(displayOAuthPageOn view: UIViewController, error: ((AnyObject?) -> Void)?, success: @escaping (String) -> Void) {
        
        let state = generateState(withLength: 10)
        
        let handler = SafariURLHandler(viewController: view, oauthSwift: oauthswift)
        handler.presentCompletion = {
            print("Safari presented")
        }
        handler.dismissCompletion = {
            print("Safari dismissed")
        }
        
        oauthswift.authorizeURLHandler = handler
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "com.rwp.tddashboard://oauth-callback")!,
            scope: "data:read",
            state: state,
            success: { credential, response, parameters in
                success(credential.oauthToken)
            },
            failure: { error in
                // TODO: handle error properly
                print(error.errorCode)
                print(error.errorUserInfo)
                print(error.localizedDescription)
            }
        )
        
        
    }
    
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
