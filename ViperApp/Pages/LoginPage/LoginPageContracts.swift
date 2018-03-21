//
//  LoginPageContracts.swift
//  ViperApp
//
//  Created by Romson Preechawit on 22/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import UIKit

// #########################################################################
// MARK - Protocols
// #########################################################################
/*
 These naming are PRESENTATOR centric.
 e.g.
 RWPViewInput is the view's input FROM the PRESENTATOR
 RWPRouterOutput is the router's output TO the PRESENTATOR
 
 The naming scheme Input/Output is used instead of delegate and
 the like to avoid confusion since the PRESENTATOR can be a delegate
 for the View, the Interactor, and the Router, all at the same time.
 
 */

// ------------------------------
// VIEW <- PRESENTATOR
// ------------------------------
// This defines what the view can show.
protocol LoginPageViewInput: RWPViewInput {
    
}

// ------------------------------
// VIEW -> PRESENTATOR
// ------------------------------
// This defines what the view SHOULD tell the
// presentator and what UI action the presentator
// can handle.
//
// (Basically View Delegate)
protocol LoginPageViewOutput: RWPViewOutput {
    func initiateLoginProcedure()
}

// ------------------------------
// ROUTER <- PRESENTATOR
// ------------------------------
// This defines where can the Presentator
// tell the router to route to.
protocol LoginPageRouterInput: RWPRouterInput {
    func showLoginPage()
}

// ------------------------------
// ROUTER -> PRESENTATOR
// ------------------------------
// This allow the router to pass data to
// the presentator.
protocol LoginPageRouterOutput: RWPRouterOutput {
}

// ------------------------------
// INTERACTOR <- PRESENTATOR
// ------------------------------
// This define what action can the interactor
// complete for the presentator.
protocol LoginPageInteractorInput: RWPInteractorInput {
    
}

// ------------------------------
// INTERACTOR -> PRESENTATOR
// ------------------------------
// This allow the interactor to pass data back
// to the presentator.
protocol LoginPageInteractorOutput: RWPInteractorOutput {
    
}

// #########################################################################
// MARK - Cross module communication protocols
// #########################################################################

// This is for other module to pass data back to this module
protocol LoginPageModuleInput: RWPModuleInput {
    /// Return with either an Error or a Success<String> with "token" inside
    func didReturnWithLoginResult(login result:NetworkResult<String>)
}
