//
//  PhotoDetailView.swift
//  iOSCodeTest
//
//  Created by john.fkennedy on 2021/08/15.
//

import SwiftUI

struct PhotoDetailView: View {
    
    @State private(set) var photoIndex: Int
    
    var body: some View {
        Text(String(photoIndex))
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photoIndex: 0)
    }
}
