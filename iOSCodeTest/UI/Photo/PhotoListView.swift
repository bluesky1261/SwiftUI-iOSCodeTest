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
        Text("").onAppear {
            self.viewModel.getPhoto()
        }
    }
    
    var loadingView: some View {
        Text("")
    }
    
    func failedView(_ error: Error) -> some View {
        Text("")
    }
}

// MARK: - Displaying Content
private extension PhotoListView {
    func loadedView(topic: TopicModel, photos: [PhotoModel]) -> some View {
        ScrollView {
            LazyVStack(spacing: 0.0) {
                ForEach(photos) { photo in
                    Button(action: {
                    
                    }, label: {
                        PhotoImage(urlString: photo.urls.raw!) {
                            Text("")
                        }
                        .aspectRatio(contentMode: .fit)
                    })
                }
            }
        }
    }
}

struct PhotoImage<Placeholder: View>: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholder: Placeholder
    
    init(urlString: String, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _imageLoader = StateObject(wrappedValue: ImageLoader(urlString:urlString))
    }
    
    var body: some View {
        content
            .onAppear(perform: imageLoader.loadImage)
    }
    
    private var content: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
