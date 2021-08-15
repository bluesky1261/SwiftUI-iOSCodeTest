//
//  PhotoMainView.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/13.
//

import SwiftUI

struct PhotoMainView: View {
    @ObservedObject private(set) var viewModel: PhotoMainViewModel
    
    var body: some View {
        NavigationView {
            self.content
            .navigationTitle("Unsplash")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var content: AnyView {
        switch viewModel.topics {
        case .notRequested:
        return AnyView(notRequestedView)
        case .isLoading(_, _):
            return AnyView(loadingView)
        case let .loaded(topics):
            return AnyView(loadedView(topics))
        case let .failed(_):
            return AnyView(failedView)
        }
    }

}

private extension PhotoMainView {
    var notRequestedView: some View {
        Text("").onAppear(perform: self.viewModel.getTopic)
    }
    
    var loadingView: some View {
        Text("")
    }
    
    var failedView: some View {
        Text("")
    }
}

private extension PhotoMainView {
    func loadedView(_ topics: [TopicModel]) -> some View {
        VStack(spacing: 0.0) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(topics) { topic in
                        Button(action: {
                        
                        }, label: {
                            Text(topic.title)
                                .foregroundColor(.black)
                                .font(.body)
                        })
                    }
                }
                .frame(height: 30, alignment: .topLeading)
            }
            // MARK: - TODO
            PhotoListView(viewModel: .init(container: viewModel.container, topic: topics.first!))
        }
    }
}


// MARK: - Preview

#if DEBUG
struct PhotoMainView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoMainView(viewModel: .init(container: .preview))
    }
}
#endif
