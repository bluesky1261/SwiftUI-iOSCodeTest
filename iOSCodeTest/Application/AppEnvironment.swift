//
//  AppEnvironment.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/12.
//

import Combine

struct AppEnvironment {
    let container: DIContainer
    //let systemEventHandler: SystemEventHandler
}

extension AppEnvironment {
    static func bootStrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let services = configureServices()
        let diContainer = DIContainer(appState: appState, services: services)
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func configureServices() -> DIContainer.Services {
        let topicService = TopicServiceImpl()
        let photoService = PhotoServiceImpl()
        return .init(topicService: topicService, photoService: photoService)
    }
}
