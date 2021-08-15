//
//  ImageLoader.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/19.
//

import SwiftUI
import Combine
import Alamofire

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let cancelBag = CancelBag()
    private let imageURL: URL?

    init(urlString:String) {
        guard var urlComponent = URLComponents(string: urlString) else {
            self.imageURL = nil
            return
        }
        
        // 파라미터 셋팅
        var parameters = [URLQueryItem]()
        parameters.append(URLQueryItem(name: "w", value: "\(Int(UIScreen.main.bounds.size.width))"))
        parameters.append(URLQueryItem(name: "dpr", value: "\(Int(UIScreen.main.scale))"))
        parameters.append(URLQueryItem(name: "fm", value: "jpg"))
        parameters.append(URLQueryItem(name: "fit", value: "max"))
        parameters.append(URLQueryItem(name: "q", value: "80"))
        
        urlComponent.queryItems = parameters
        
        self.imageURL = urlComponent.url
    }
    
    func loadImage() {
        if let imageURL = imageURL {
            // Image From Cache
            if let cacheImage = ImageCache.shared.getImage(identifier: imageURL.absoluteString) {
                DispatchQueue.main.async {
                    self.image = cacheImage
                }
            } else {
                AF.request(imageURL)
                    .validate()
                    .publishData()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { [weak self] response in
                        guard let data = response.value, let image = UIImage(data: data) else {
                            print("Image Fetch Error Occurred")
                            return
                        }
                        
                        self?.image = image
                        ImageCache.shared.add(image: image, identifier: imageURL.absoluteString)
                    })
                    .store(in: cancelBag)
            }
        } else {
            print("*** Image URL Error")
        }
    }
    
    func cancelImage() {
        cancelBag.cancel()
    }
}
