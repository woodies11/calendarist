//
//  LoginPagePresentator.swift
//  ViperApp
//
//  Created by Romson Preechawit on 20/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation


protocol LoginPagePresentatorProtocol {
    
}

class LoginPagePresentator: LoginPagePresentatorProtocol {
    
    weak var view: LoginPageViewControllerProtocol!
    var interactor: LoginPageInteractorProtocol!
    var router: LoginPageRouterProtocol!
    
}
