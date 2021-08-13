//
//  DependencyInjector.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/12.
//

import SwiftUI

struct DIContainer: EnvironmentKey {
    let appState: Store<AppState>
    let services: Services
    
    static var defaultValue: Self { self.default }
    
    private static let `default` = DIContainer(appState: AppState(), services: .stub)
    
    init(appState: Store<AppState>, services: DIContainer.Services) {
        self.appState = appState
        self.services = services
    }
    
    init(appState: AppState, services: DIContainer.Services) {
        self.init(appState: Store(appState), services: services)
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: AppState.preview, services: .stub)
    }
}
#endif
