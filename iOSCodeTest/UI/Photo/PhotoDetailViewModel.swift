//
//  PhotoDetailViewModel.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/15.
//

import Foundation

struct PhotoDetailRouting: Equatable {
    var showPhotoDetail: Bool = false
}

class PhotoDetailViewModel: ObservableObject {
    
    @Published var photo: Loadable<PhotoModel>
    
    let container: DIContainer
    private let cancelBag = CancelBag()
    
    init(container: DIContainer, photo: Loadable<PhotoModel> = .notRequested) {
        self.container = container
        
        _photo = .init(initialValue: photo)
    }
}
