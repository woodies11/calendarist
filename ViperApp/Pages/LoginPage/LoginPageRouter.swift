//
//  LoginPageProtocols.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit
import OAuthSwift

protocol LoginPageRouterProtocol {
    static func createModule(tdService: TDServiceProtocol) -> UIViewController
    func showLoginPage()
}

protocol LoginPageRouterDelegate {
    /// Return with either an Error or a Success<String> with "token" inside
    func didReturnWithLoginResult(login result:NetworkResult<String>)
}

class LoginPageRouter: RWPRouter, LoginPageRouterProtocol {
    
    weak var view: UIViewController!
    var presentator: LoginPagePresentatorInput!
    var tdService: TDServiceProtocol!
    
    class func createModule(tdService: TDServiceProtocol) -> UIViewController {
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
        router.tdService = tdService
        
        loginViewController.presentator = presentator
        
        return loginViewController
        
    }
    
    func showLoginPage() {
        tdService.initiateOAuth(sourceView: self.view) { (result) in
            switch result {
            case .success( _):
                self.showDashboard()
            case .error:
                ()
            }
        }
    }
    
    func showDashboard() {
        let dashboardView = DashboardRouter.createModule(tdService: tdService)
        self.view.show(dashboardView, sender: self.view)
    }
    
}
