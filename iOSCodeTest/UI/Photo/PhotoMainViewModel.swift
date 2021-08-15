//
//  PhotoMainViewModel.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import SwiftUI
import Combine

struct PhotoMainRouting: Equatable {
    var photoDetail: Int?
}

class PhotoMainViewModel: ObservableObject {
    @Published var routingState: PhotoMainRouting
    @Published var topics: Loadable<[TopicModel]>
    
    let container: DIContainer
    private let cancelBag = CancelBag()
    
    init(container: DIContainer, topics: Loadable<[TopicModel]> = .notRequested) {
        let appState = container.appState
        
        _routingState = .init(initialValue: appState.value.routing.photoMain)
        _topics = .init(initialValue: topics)
        
        self.container = container
    }
    
    func getTopic() {
        container.services.topicService.getTopic(topics: loadableSubject(\.topics))
    }
}
