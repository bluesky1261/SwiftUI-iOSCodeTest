//
//  CategoryViewModel.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import Foundation
import Combine
import Alamofire

class TopicViewModel: ObservableObject {
    @Published var topics = [TopicModel]()
    var publisher = PassthroughSubject<String, Never>()
    
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    // Get Topic Combine
    func getTopic() {
        guard !isLoading else { return }
        self.isLoading = true
        
        self.currentPage += 1
        let parameters: [String: String] = ["page": "\(self.currentPage)", "client_id": Server.API_ACCESS_KEY]

        AF.request(Server.LIST_TOPIC_URL, method: .get, parameters: parameters)
            .validate()
            .publishDecodable(type: [TopicModel].self)
            .sink { response in
                self.isLoading = false
                guard response.error == nil, let result = response.value else { return }
                
                self.topics.append(contentsOf: result)
                self.publisher.send(result.first?.id ?? "")
            }
            .store(in: &subscriptions)
    }
    
}
