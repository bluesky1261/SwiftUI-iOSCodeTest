//
//  TopicService.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import Foundation
import Combine
import Alamofire

protocol TopicService {
    func getTopic(topics: LoadableSubject<[TopicModel]>, page: Int)
}

extension TopicService {
    func getTopic(topics: LoadableSubject<[TopicModel]>, page: Int = 1) {
        getTopic(topics: topics, page: page)
    }
}

struct TopicServiceImpl: TopicService {
    func getTopic(topics: LoadableSubject<[TopicModel]>, page: Int) {
        let cancelBag = CancelBag()
        topics.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        let parameters: [String: String] = ["page": "\(page)", "client_id": Server.API_ACCESS_KEY]
        AF.request(Server.LIST_TOPIC_URL, method: .get, parameters: parameters)
            .validate()
            .publishDecodable(type: [TopicModel].self)
            .sink(receiveCompletion: { subscriptionCompletion in
                if let error = subscriptionCompletion.error {
                    topics.wrappedValue = .failed(error)
                }
            }) { response in
            
                topics.wrappedValue = .loaded(response.value ?? [TopicModel]())
            }.store(in: cancelBag)
    }
}

struct TopicServiceStub: TopicService {
    func getTopic(topics: LoadableSubject<[TopicModel]>, page: Int) {
        
    }
}
