//
//  ServicesContainer.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/12.
//

extension DIContainer {
    struct Services {
        let topicService: TopicService
        let photoService: PhotoService
        
        init(topicService: TopicService, photoService: PhotoService) {
            self.topicService = topicService
            self.photoService = photoService
        }
        
        static var stub: Self {
            .init(topicService: TopicServiceStub(), photoService: PhotoServiceStub())
        }
    }
}
