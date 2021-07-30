//
//  PhotoListView.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/21.
//

import SwiftUI

struct PhotoListView<Data, Content>: View
where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View {
    @Binding var data: Data
    @Binding var isLoading: Bool
    
    let loadMore: () -> Void
    let content: (Data.Element) -> Content
    
    init (data: Binding<Data>
        , isLoading: Binding<Bool>
        , loadMore: @escaping () -> Void
        , @ViewBuilder content: @escaping (Data.Element) -> Content) {
        _data = data
        _isLoading = isLoading
        self.loadMore = loadMore
        self.content = content
    }
    
    var body: some View {
        List {
            ForEach(0..<data.count) { index in
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
}
