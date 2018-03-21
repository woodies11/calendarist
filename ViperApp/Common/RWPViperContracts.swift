//
//  RWPViperContracts.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation
import UIKit

protocol RWPRouterProtocol {
    static var mainStoryboard: UIStoryboard { get }
}

extension RWPRouterProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

// ------------------------------
// PRESENTATOR -> VIEW
// ------------------------------
// This defines what the view can show.

// ------------------------------
// VIEW -> PRESENTATOR
// ------------------------------
// This defines what the view SHOULD tell the
// presentator and what UI action the presentator
// can handle.

// ------------------------------
// PRESENTATOR -> ROUTER
// ------------------------------
// This defines where can the Presentator
// tell the router to route to.

// ------------------------------
// ROUTER -> PRESENTATOR
// ------------------------------
// This allow the router to pass data to
// the presentator.

// ------------------------------
// PRESENTATOR -> INTERACTOR
// ------------------------------
// This define what action can the interactor
// complete for the presentator.

// ------------------------------
// INTERACTOR -> PRESENTATOR
// ------------------------------
// This allow the interactor to pass data back
// to the presentator.

