//
//  UserDefaultsExtention.swift
//  ViperAppTests
//
//  Created by Romson Preechawit on 22/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import Foundation

// This can actually be avoid if we wrap UserDefault in
// a data manager of some kind.

/// Use for testing UserDefaults.
/// Will make sure UserDefaults is blank when start
/// executing handler and restore to previous state
/// after it finish executing.
extension UserDefaults {
    static func blankDefaultsWhile(handler:()->Void){
        let bundle = Bundle.main
        let defs = UserDefaults.standard
        guard let name = bundle.bundleIdentifier else {
            fatalError("Couldn't find bundle ID.")
        }
        let old = defs.persistentDomain(forName: name)
        defer {
            defs.setPersistentDomain( old ?? [:],
                                      forName: name)
        }
        
        defs.removePersistentDomain(forName: name)
        handler()
    }
}
