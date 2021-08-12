//
//  PhotoViewModel.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/19.
//

import Foundation
import Combine
import Alamofire

class PhotoViewModel: ObservableObject {
    @Published var photos = [PhotoModel]()
    
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    func getPhoto(topic: String) {
        guard !isLoading else { return }
        self.isLoading = true
        
        self.currentPage += 1
        print("Get Photos with topic: \(topic) / page: \(self.currentPage) Start")
        let parameters: [String: String] = ["page": "\(self.currentPage)", "client_id": Server.API_ACCESS_KEY]
        
        let urlByTopic = Server.LIST_TOPIC_URL + "/\(topic)/photos"

        AF.request(urlByTopic, method: .get, parameters: parameters)
            .validate()
            .publishDecodable(type: [PhotoModel].self)
            .sink { response in
                self.isLoading = false
                guard response.error == nil, let result = response.value else {
                    print("Get Photos Error Occurred")
                    return
                }
                
                self.photos.append(contentsOf: result)
                print("Get Photos with topic: \(topic) / page: \(self.currentPage) End")
            }
            .store(in: &subscriptions)
    }
}
