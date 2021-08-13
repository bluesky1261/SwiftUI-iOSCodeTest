//
//  ContentView.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject private(set) var viewModel: MainContentViewModel
    
    var body: some View {
        TabView {
            PhotoMainView()
                .tabItem {
                    Text("Photo")
                }
            SearchListView()
                .tabItem {
                    Text("Search")
                }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: MainContentViewModel(container: .preview))
    }
}
