//
//  File.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import OAuthSwift

protocol TDOAuthServiceProtocol {
    func initiateOAuth(displayOAuthPageOn view: UIViewController, error: ((AnyObject?) -> Void)?, success: @escaping (String) -> Void)
}

// : AnyObject in Swift 4 == : class in Swift 3
protocol OAuthService: AnyObject {
    func initiateOAuth(displayOAuthPageOn view: UIViewController, error: ((AnyObject?) -> Void)?, success: @escaping (String) -> Void)
}

class TDOAuthService: TDOAuthServiceProtocol, OAuthService {
    
    let oauthswift = OAuth2Swift(
        consumerKey: "6708fc59ee7f4746a6ea4ef13f660585",
        consumerSecret: "0cee40bbdcbf4d38bf68b0ff9caaf8ac",
        authorizeUrl: "https://todoist.com/oauth/authorize",
        accessTokenUrl: "https://todoist.com/oauth/access_token",
        responseType: "code"
    )
    
    func initiateOAuth(displayOAuthPageOn view: UIViewController, error: ((AnyObject?) -> Void)?, success: @escaping (String) -> Void) {
        
        // set handler to use an internal Safari WebKit
        let handler = SafariURLHandler(viewController: view, oauthSwift: oauthswift)
        
        // OAuthSwift call success(...) completion handler
        // asynchronously with the handler.dismissCompletion.
        // This sometime causes problem where success(...) may
        // fires before the SafariURLHandler finish dismissing
        // which causes problem when trying to present a view
        // after the login is complete.
        
        // This dispatchGroup make sure that both completion
        // handlers is completed before notifying the completion
        // handler given by the user of this function
        let dispatchGroup = DispatchGroup()
        
        // a token variable to capture oauthtoken string from
        // OAuthSwift's compltion handler before passing it
        // back upon DispatchGroup finishing.
        var token: String?
        
        // Enter dispatch group when presenting Safari and leave
        // when fully dismissed.
        handler.presentCompletion = {
            dispatchGroup.enter()
        }
        handler.dismissCompletion = {
            dispatchGroup.leave()
        }
        
        oauthswift.authorizeURLHandler = handler
        
        // Initiate OAuth2 flow using OAuthSwift.
        // Enter the dispatch once more for our Authorize flow.
        dispatchGroup.enter()
        
        // generate a random string to verify integrity of our response
        let state = generateState(withLength: 10)
        
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "com.rwp.tddashboard://oauth-callback")!,
            scope: "data:read",
            state: state,
            success: { credential, response, parameters in
                token = credential.oauthToken
                // Tell dispatchGroup we have received and stored the token.
                dispatchGroup.leave()
            },
            failure: { error in
                // TODO: tell the user about the Error
                print(error.errorCode)
                print(error.errorUserInfo)
                print(error.localizedDescription)
                dispatchGroup.leave()
            }
        )
        
        // Once we have received the token AND the handler is completely
        // dismissed, we then execute completion handlers given by the
        // user of this function.
        dispatchGroup.notify(queue: .main) {
            if let token = token {
                success(token)
            } else {
                // TODO: capture and forward error
                error?(nil)
            }
        }
        
        
    }
    
}
