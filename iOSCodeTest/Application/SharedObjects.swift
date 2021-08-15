//
//  SharedObjects.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/16.
//

import Foundation

class SharedObjects: ObservableObject {
    @Published var topics: Loadable<[TopicModel]>
    @Published var photos: Loadable<[PhotoModel]>
    
    init(topics: Loadable<[TopicModel]> = .notRequested,
         photos: Loadable<[PhotoModel]> = .notRequested) {
        
        _topics = .init(initialValue: topics)
        _photos = .init(initialValue: photos)
    }
}
