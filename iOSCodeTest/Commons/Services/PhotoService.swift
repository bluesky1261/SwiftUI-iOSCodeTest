//
//  PhotoService.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/19.
//

import Foundation
import Alamofire

typealias PhotoListCompletionHandler = ([PhotoModel]?) -> Void

class PhotoService {
    static let shared = PhotoService()

    private init() { }
}

extension PhotoService {
    /// 서버로부터 네트워크 통신을 통하여 사진 리스트를 받아오는 함수.
    func getPhotoList(page: Int, topic: String? = nil, completion: @escaping PhotoListCompletionHandler) {
        let parameters: [String: String] = ["page": "\(page)", "client_id": Server.API_ACCESS_KEY]

        // 조회 대상 Topic이 존재하는 경우
        if let topic = topic {
            let urlByTopic = Server.LIST_TOPIC_URL + "/\(topic)/photos"
            AF.request(urlByTopic, method: .get, parameters: parameters).responseData { (responseData) in
                switch responseData.result {
                case .success(let resultData):
                    do {
                        let photoModel = try [PhotoModel].decode(data: resultData)
                        completion(photoModel)
                    } catch let decodeError as NSError {
                        completion(nil)
                        print(decodeError.localizedDescription)
                    }
                case .failure(let error):
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
        // 조회 대상 Topic이 존재하지 않는 경우
        } else {
            AF.request(Server.LIST_PHOTO_URL, method: .get, parameters: parameters).responseData { (responseData) in
                switch responseData.result {
                case .success(let resultData):
                    do {
                        let photoModel = try [PhotoModel].decode(data: resultData)
                        completion(photoModel)
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

    // MARK: TODO
    func loadPhotoImage() {
    }

    /// 검색어를 통하여 검색어에 해당하는 사진 리스트를 받아오는 함수.
    func searchPhoto(page: Int, searchText: String, completion: @escaping PhotoListCompletionHandler) {
        let parameters: [String: String] = ["page": "\(page)", "query": "\(searchText)", "client_id": Server.API_ACCESS_KEY]

        AF.request(Server.SEARCH_PHOTO_URL, method: .get, parameters: parameters).responseData { (responseData) in
            switch responseData.result {
            case .success(let resultData):
                do {
                    let photoSearchResultModel = try PhotoSearchResultModel.decode(data: resultData)
                    completion(photoSearchResultModel.results)
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
