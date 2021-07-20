//
//  ImageLoader.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/19.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard var urlComponent = URLComponents(string: urlString) else { return }
        var parameters = [URLQueryItem]()
        parameters.append(URLQueryItem(name: "w", value: "\(Int(UIScreen.main.bounds.size.width))"))
        parameters.append(URLQueryItem(name: "dpr", value: "\(Int(UIScreen.main.scale))"))
        parameters.append(URLQueryItem(name: "fm", value: "jpg"))
        parameters.append(URLQueryItem(name: "fit", value: "max"))
        parameters.append(URLQueryItem(name: "q", value: "80"))
        
        urlComponent.queryItems = parameters
        
        if let componentUrl = urlComponent.url {
            let task = URLSession.shared.dataTask(with: URLRequest(url: componentUrl)) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.data = data
                }
            }
            task.resume()
        } else {
            let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.data = data
                }
            }
            task.resume()
        }
    }
}
