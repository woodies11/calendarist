//
//  LoginPageProtocols.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

protocol LoginPageRouterProtocol: RouterProtocol {
    static func createModule() -> UIViewController
}

class LoginPageRouter: LoginPageRouterProtocol {
    
    weak var view: UIViewController!
    var presentator: LoginPagePresentatorProtocol!
    
    class func createModule() -> UIViewController {
        guard let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPageViewController
            else {
                fatalError("Unable to Instantiate LoginViewController from Storyboard!")
        }
        
        // Create and assign the needed component in our VIPER module
        let presentator = LoginPagePresentator()
        let interactor = LoginPageInteractor()
        let router = LoginPageRouter()
        
        presentator.interactor = interactor
        presentator.router = router
        presentator.view = loginViewController
        
        router.view = loginViewController
        router.presentator = presentator
        
        loginViewController.presentator = presentator
        
        return loginViewController
        
    }
    
    
}
