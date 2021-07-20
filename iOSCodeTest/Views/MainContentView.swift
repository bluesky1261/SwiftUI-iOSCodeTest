//
//  ContentView.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import SwiftUI

struct MainContentView: View {
    @State private var topicSection: Int = 0
    @State private var topicIndex: Int = 0
    @State private var photoSection: Int = 0
    @State private var photoIndex: Int = 0
    @ObservedObject private var topicVM = TopicViewModel()
    @ObservedObject private var photoVM = PhotoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(topicVM.topics) { topic in
                            Button(action: {
                                
                            }, label: {
                                Text(topic.title)
                                    .foregroundColor(.black)
                                    .font(.body)
                            })
                        }
                    }
                }
                .background(Color.orange)
                ScrollView(.vertical) {
                    VStack {
                        if photoVM.photos.count > 0 {
                            ForEach(Range(0...photoVM.photos.count - 1)) { index in
                                ForEach(photoVM.photos[index]!) { photo in
                                    Button(action: {
                                        
                                    }, label: {
                                        if let photoUrl = photo.urls.raw {
                                            let _ = print("\(photo.user.name) / \(photo.sponsorship?.sponsor.name)")
                                            PhotoView(withURL: photoUrl, pictureName: photo.user.name, sponsorName: photo.sponsorship?.sponsor.name)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
                .background(Color.green)
            }
            .background(Color.red)
            .navigationTitle("Unsplash")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            topicVM.fetchTopic()
        })
        .onReceive(topicVM.publisher) { topicId in
            photoVM.fetchPhoto(with: topicId)
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
