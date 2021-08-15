//
//  PhotoListViewModel.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import Foundation
import Combine

class PhotoListViewModel: ObservableObject {
    let topic: TopicModel
    @Published var photos: Loadable<[PhotoModel]>
    
    let container: DIContainer
    private let cancelBag = CancelBag()
    
    init(container: DIContainer, topic: TopicModel, photos: Loadable<[PhotoModel]> = .notRequested) {
        self.topic = topic
        self.container = container
        
        _photos = .init(initialValue: photos)
    }
    
    func getPhoto() {
        container.services.photoService.getPhoto(photos: loadableSubject(\.photos), topic: topic)
    }
}
