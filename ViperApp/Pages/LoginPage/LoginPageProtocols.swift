//
//  LoginPageProtocols.swift
//  ViperApp
//
//  Created by Romson Preechawit on 16/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

protocol LoginPageRouter: AnyObject {
    static func createLoginPageModule() -> UIViewController
}
