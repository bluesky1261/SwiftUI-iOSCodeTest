//
//  PhotoListView.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/21.
//

import SwiftUI

struct PhotoListView: View {
    //@Binding var data: Data
    @ObservedObject private(set) var viewModel:PhotoListViewModel
    
    var body: some View {
        content
    }
    
    private var content: AnyView {
        switch viewModel.photos {
        case .notRequested:
            return AnyView(notRequestedView)
        case .isLoading(_, _):
            return AnyView(loadingView)
        case let .loaded(photos):
            return AnyView(loadedView(topic: viewModel.topic, photos: photos))
        case let .failed(error):
            return AnyView(failedView(error))
        }
    }
}

// MARK: - Loading Content
private extension PhotoListView {
    var notRequestedView: some View {
        Text("Photo List").onAppear {
            self.viewModel.getPhoto()
        }
    }
    
    var loadingView: some View {
        VStack {
            //ActivityIndicatorView()
            Button(action: {
                self.viewModel.photos.cancelLoading()
            }, label: { Text("Cancel loading") })
        }
    }
    
    func failedView(_ error: Error) -> some View {
        Text("")
    }
}

// MARK: - Displaying Content
private extension PhotoListView {
    func loadedView(topic: TopicModel, photos: [PhotoModel]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(photos) { photo in
                    let imageLoader = ImageLoader(urlString:photo.urls.raw!)
                    Button(action: {
                    
                    }, label: {
                        Text(photo.id)
                        /*
                        Image(uiImage: UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onReceive(imageLoader.publisher) { data in
                                self.image = UIImage(data: data) ?? UIImage()
                            }
 */

                    })
                }
            }
            .frame(height: 30, alignment: .topLeading)
        }
    }
}
