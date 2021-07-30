//
//  PhotoView.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/19.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State private var image:UIImage = UIImage()

    init(withURL url:String, pictureName: String?, sponsorName: String?) {
        self.imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onReceive(imageLoader.publishser) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                }
        }
    }

}
