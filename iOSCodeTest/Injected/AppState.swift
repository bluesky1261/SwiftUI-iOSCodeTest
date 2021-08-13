//
//  AppState.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/12.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var routing = ViewRouting()
    var system = System()
}

// MARK: - Extension: ViewRouting
extension AppState {
    struct ViewRouting: Equatable {
    
    }
}

// MARK: - Extension: System
extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
