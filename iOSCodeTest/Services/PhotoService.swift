//
//  PhotoService.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import Foundation
import Combine

protocol PhotoService {
    func getPhoto(topic: String)
}

// MARK: - PhotoService Implementation
struct PhotoServiceImpl: PhotoService {
    func getPhoto(topic: String) {
        
    }
}

// MARK: - PhotoServiceTest
struct PhotoServiceStub: PhotoService {
    func getPhoto(topic: String) {
        
    }
}
