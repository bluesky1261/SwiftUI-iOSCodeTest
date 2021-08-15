//
//  PhotoService.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import Foundation
import Combine
import Alamofire

protocol PhotoService {
    func getPhoto(photos: LoadableSubject<[PhotoModel]>, topic: TopicModel, page: Int)
}

extension PhotoService {
    func getPhoto(photos: LoadableSubject<[PhotoModel]>, topic: TopicModel, page: Int = 0) {
        getPhoto(photos: photos, topic: topic, page: 0)
    }
}

// MARK: - PhotoService Implementation
struct PhotoServiceImpl: PhotoService {
    func getPhoto(photos: LoadableSubject<[PhotoModel]>, topic: TopicModel, page: Int) {
        let cancelBag = CancelBag()
        photos.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        let parameters: [String: String] = ["page": "\(page)", "client_id": Server.API_ACCESS_KEY]
        let urlByTopic = Server.LIST_TOPIC_URL + "/\(topic.id)/photos"

        AF.request(urlByTopic, method: .get, parameters: parameters)
            .validate()
            .publishDecodable(type: [PhotoModel].self)
            .sink(receiveCompletion: { subscriptionCompletion in
                if let error = subscriptionCompletion.error {
                    photos.wrappedValue = .failed(error)
                }
            }) { response in
                photos.wrappedValue = .loaded(response.value ?? [PhotoModel]())
            }.store(in: cancelBag)
    }
}

// MARK: - PhotoServiceTest
struct PhotoServiceStub: PhotoService {
    func getPhoto(photos: LoadableSubject<[PhotoModel]>, topic: TopicModel, page: Int) {
        
    }
}
