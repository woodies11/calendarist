//
//  LoginPagePresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 20/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation


protocol LoginPagePresentatorInput: RWPRouterOutput {
    func initiateLoginProcedure()
}

class LoginPagePresentator: LoginPagePresentatorInput {
    
    weak var view: LoginPageViewControllerProtocol!
    var interactor: LoginPageInteractorProtocol!
    var router: LoginPageRouterProtocol!
    
    func initiateLoginProcedure() {
        router.showLoginPage()
    }
    
}
