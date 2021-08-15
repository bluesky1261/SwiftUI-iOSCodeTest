//
//  iOSCodeTestApp.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/18.
//

import SwiftUI

@main
struct iOSCodeTestApp: App {
    @StateObject var environmentObject = SharedObjects()
    
    var body: some Scene {
        WindowGroup {
            let environment: AppEnvironment = AppEnvironment.bootStrap()
            MainContentView(viewModel: MainContentViewModel(container: environment.container))
                .environmentObject(environmentObject)
        }
    }
}
