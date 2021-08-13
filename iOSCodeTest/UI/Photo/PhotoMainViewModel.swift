//
//  PhotoMainViewModel.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import SwiftUI
import Combine

class PhotoMainViewModel: ObservableObject {
    
    @Published var topics: Loadable<[TopicModel]>
    
    let container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer, topics: Loadable<[TopicModel]> = .notRequested) {
        _topics = .init(initialValue: topics)
        
        self.container = container
    }
    
    func getTopic() {
        container.services.topicService.getTopic(topics: loadableSubject(\.topics))
    }
}
