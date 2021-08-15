//
//  ImageCache.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/15.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageCache {
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    static let shared = ImageCache()
    
    func add(image: Image, identifier: String) {
        imageCache.add(image, withIdentifier: identifier)
    }
    
    func getImage(identifier: String) -> Image? {
        return imageCache.image(withIdentifier: identifier)
    }
}
