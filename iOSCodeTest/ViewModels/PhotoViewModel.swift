//
//  PhotoViewModel.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/19.
//

import Foundation

class PhotoViewModel: ObservableObject {
    @Published var photos: [Int:[PhotoModel]] = .init()
    private let photoService = PhotoService.shared
    
    func fetchPhoto(page: Int = 0, with topic: String) {
        photoService.getPhotoList(page: page, topic: topic) { photoModel in
            guard let photoModel = photoModel else { return }

            self.photos[page] = photoModel

            DispatchQueue.main.async {
                self.photos[page] = photoModel
            }
        }
    }
}
