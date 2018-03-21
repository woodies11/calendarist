//
//  LoginPagePresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 20/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

class LoginPagePresentator: LoginPageViewOutput, LoginPageInteractorOutput, LoginPageRouterOutput {
    
    weak var view: LoginPageViewInput!
    var interactor: LoginPageInteractorInput!
    var router: LoginPageRouterInput!
    
    func initiateLoginProcedure() {
        // Since this navigate to Safari to complete,
        // it is the job of the router.
        router.showLoginPage()
    }
    
}
