//
//  ServicesContainer.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/12.
//

extension DIContainer {
    struct Services {
        let photoService: PhotoService
        
        init(photoService: PhotoService) {
            self.photoService = photoService
        }
        
        static var stub: Self {
            .init(photoService: PhotoServiceStub())
        }
    }
}
