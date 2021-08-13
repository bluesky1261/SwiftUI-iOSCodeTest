//
//  MainContentViewModel.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import Foundation

class MainContentViewModel: ObservableObject {
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
}
