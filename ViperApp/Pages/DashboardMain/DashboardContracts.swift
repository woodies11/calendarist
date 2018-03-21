//
//  DashboardContracts.swift
//  ViperApp
//
//  Created by Romson Preechawit on 21/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

import Foundation
import UIKit

// #########################################################################
// Protocols
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
protocol DashboardViewInput: RWPViewInput {
    func showTasks(taskList: [Date: [String]])
    func showAlert(title: String, message: String)
    func presentViewModally(viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

// ------------------------------
// VIEW -> PRESENTATOR
// ------------------------------
// This defines what the view SHOULD tell the
// presentator and what UI action the presentator
// can handle.
//
// (Basically View Delegate)
protocol DashboardViewOutput: RWPViewOutput {
    func viewDidLoad()
    func onFilterButtonTapped()
    func onLogoutButtonTapped()
}

// ------------------------------
// ROUTER <- PRESENTATOR
// ------------------------------
// This defines where can the Presentator
// tell the router to route to.
protocol DashboardRouterInput: RWPRouterInput {
    static func createModule(tdService: TDServiceProtocol) -> UIViewController
    func presentFilterList(initial filters: [Filter]?)
    func navigateBackToLogin()
}

// ------------------------------
// ROUTER -> PRESENTATOR
// ------------------------------
// This allow the router to pass data to
// the presentator.
protocol DashboardRouterOutput: RWPRouterOutput {
    func filterUpdated(filters: [Filter])
}

// ------------------------------
// INTERACTOR <- PRESENTATOR
// ------------------------------
// This define what action can the interactor
// complete for the presentator.
protocol DashboardInteractorInput: RWPInteractorInput {
    func getTasks(withFilters filters: [Filter]?, completion: @escaping NetworkCompletionHandler<[Date: [String]]>)
    func clearUserCredential()
}

// ------------------------------
// INTERACTOR -> PRESENTATOR
// ------------------------------
// This allow the interactor to pass data back
// to the presentator.
protocol DashboardInteractorOutput: RWPInteractorOutput {
}

