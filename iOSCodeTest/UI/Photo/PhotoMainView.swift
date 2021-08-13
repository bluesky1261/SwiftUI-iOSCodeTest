//
//  PhotoMainView.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import SwiftUI

struct PhotoMainView: View {
    @State private var topicSection: Int = 0
    @State private var topicIndex: Int = 0
    @State private var photoSection: Int = 0
    @State private var photoIndex: Int = 0
    @ObservedObject private var topicVM = TopicViewModel()
    @ObservedObject private var photoVM = PhotoViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(topicVM.topics) { topic in
                            Button(action: {
                                changeTopic(topicId: topic.id)
                            }, label: {
                                Text(topic.title)
                                    .foregroundColor(.black)
                                    .font(.body)
                                    //.frame(height: 20, alignment: .topLeading)
                            })
                            .onAppear() {
                                if topic.id == topicVM.topics.last?.id {
                                    topicVM.getTopic()
                                }
                            }
                        }
                    }
                }
                .frame(height: 30, alignment: .topLeading)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0.0) {
                        ForEach(photoVM.photos) { photo in
                            Button(action: {
                                
                            }, label: {
                                if let photoUrl = photo.urls.raw {
                                    PhotoView(withURL: photoUrl, pictureName: photo.user.name, sponsorName: photo.sponsorship?.sponsor.name)
                                }
                            })
                            .onAppear() {
                                if photo == photoVM.photos.last {
                                    photoVM.getPhoto(topic: topicVM.topics[topicIndex].id)
                                }
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Unsplash")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            topicVM.getTopic()
        })
        .onReceive(topicVM.publisher) { topicId in
            photoVM.getPhoto(topic: topicId)
        }
    }
    
    func changeTopic(topicId: String) {
        self.topicIndex = topicIndex
        self.photoVM.getPhoto(topic: topicVM.topics[topicIndex].id)
    }
}

struct PhotoMainView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoMainView()
    }
}
