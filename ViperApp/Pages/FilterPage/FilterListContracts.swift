//
//  FilterListContracts.swift
//  ViperApp
//
//  Created by Romson Preechawit on 21/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

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
protocol FilterListViewInput: RWPViewInput {
    func showFilters(filters: [Filter])
}

// ------------------------------
// VIEW -> PRESENTATOR
// ------------------------------
// This defines what the view SHOULD tell the
// presentator and what UI action the presentator
// can handle.
//
// (Basically View Delegate)
protocol FilterListViewOutput: RWPViewOutput {
    func viewDidLoad()
    func onDoneTapped()
    func onSegmentChange(to page: FilterType)
}

// ------------------------------
// ROUTER <- PRESENTATOR
// ------------------------------
// This defines where can the Presentator
// tell the router to route to.
protocol FilterListRouterInput: RWPRouterInput {
}

// ------------------------------
// ROUTER -> PRESENTATOR
// ------------------------------
// This allow the router to pass data to
// the presentator.
protocol FilterListRouterOutput: RWPRouterOutput {
}

// ------------------------------
// INTERACTOR <- PRESENTATOR
// ------------------------------
// This define what action can the interactor
// complete for the presentator.
protocol FilterListInteractorInput: RWPInteractorInput {
}

// ------------------------------
// INTERACTOR -> PRESENTATOR
// ------------------------------
// This allow the interactor to pass data back
// to the presentator.
protocol FilterListInteractorOutput: RWPInteractorOutput {
}
