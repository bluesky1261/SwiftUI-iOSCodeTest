//
//  PhotoListView.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/21.
//

import SwiftUI

struct PhotoListView<Content>: View where Content: View {
    //@Binding var data: Data
    @ObservedObject private var photoVM = PhotoViewModel()
    var topicId: String
    
    //let loadMore: () -> Void
    let content: (PhotoModel) -> Content
    
    init (topicId: String
        , @ViewBuilder content: @escaping (PhotoModel) -> Content) {
        //_data = data
        //_isLoading = isLoading
        self.topicId = topicId
        //self.loadMore = loadMore
        self.content = content
    }
    
    var body: some View {
        List {
            ForEach(photoVM.photos) { photo in
                content(photo)
                    .onAppear {
                        if photo == photoVM.photos.last {
                            photoVM.getPhoto(topic: topicId)
                        }
                    }
            }
                /*
                ForEach(data[index]) { photo in
                    Button(action: {
                            
                    }, label: {
                        if let photoUrl = photo.urls.raw {
                            PhotoView(withURL: photoUrl, pictureName: photo.user.name, sponsorName: photo.sponsorship?.sponsor.name)
                                .onAppear {
                                    print("*** onAppear Called")
                                    /*
                                    if photoVM.photos[photoSection]?.last == photo {
                                        self.photoSection += 1
                                        self.photoVM.fetchPhoto(page: photoSection, with: topicVM.topics[topicIndex].id)
                                    } */
                                }
                        }
                    })
                }
 */
        }
    }
}
