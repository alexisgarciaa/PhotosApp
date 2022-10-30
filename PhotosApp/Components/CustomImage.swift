//
//  CustomImage.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI

struct CustomImage: View {
    @StateObject private var viewModel = CustomImageViewModel()
    @State var imageInfo: PhotosData
    var body: some View{
        ZStack{
            if let image = viewModel.image{
                Rectangle()
                    .frame(height: 130)
                    .overlay {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            }
        }
        .onAppear{
            viewModel.downloadimage(serverId: imageInfo.server ?? "", photoId: imageInfo.id ?? "", secret: imageInfo.secret ?? "")
        }

    }
}


struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage(imageInfo: PhotosData(id: "", owner: "", secret: "", server: "", farm: 0, title: "", isPublic: 0, isFriend: 0, isFamily: 0))
    }
}
