//
//  CategoryService.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import Foundation
import Alamofire

typealias TopicListCompletionHandler = ([TopicModel]?) -> Void

// TODO: Router 처리
class TopicService {
    static let shared = TopicService()
    
    private init() { }
    

    /// 서버로부터 네트워크 통신을 통하여 카테고리의 리스트를 받아오는 함수.
    func getTopicList(page: Int, completion: @escaping TopicListCompletionHandler) {
        let parameters: [String: String] = ["page": "\(page)", "client_id": Server.API_ACCESS_KEY]

        AF.request(Server.LIST_TOPIC_URL, method: .get, parameters: parameters).responseData { (responseData) in
            switch responseData.result {
            case .success(let resultData):
                do {
                    let topicModel = try [TopicModel].decode(data: resultData)
                    completion(topicModel)
                } catch let decodeError as NSError {
                    completion(nil)
                    print(decodeError.localizedDescription)
                }
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
}
