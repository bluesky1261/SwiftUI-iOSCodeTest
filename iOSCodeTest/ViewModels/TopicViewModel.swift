//
//  CategoryViewModel.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import Foundation
import Combine

class TopicViewModel: ObservableObject {
    @Published var topics = [TopicModel]()
    var publisher = PassthroughSubject<String, Never>()
    
    private let topicService = TopicService.shared
    
    func fetchTopic(page: Int = 0) {
        topicService.getTopicList(page: page) { topicModel in
            
            guard let topicModel = topicModel, let selectedTopic = topicModel.first else { return }
            
            // Topic을 Publish함
            self.publisher.send(selectedTopic.id)
            
            DispatchQueue.main.async {
                self.topics = topicModel
            }
        }
    }
}
