//
//  DetailedImageView.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI

struct DetailedImageView: View {
    @StateObject private var viewModel = CustomImageViewModel()
    @State var imageInfo: PhotosData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            VStack{
                Button {
                    
                } label: {
                    TextCustomPhotoApp(text: "Open in browser >", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial.opacity(0.7))
                        .cornerRadius(5)
                        
                }

            }
        }
        .navigationTitle(imageInfo.title ?? "")
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    TextCustomPhotoApp(text: "Browser", fontName: "Poppins-Medium", fontSize: 16, fontColor: .black, alignment: .center, lineLimit: 1)
                }
            }
        })
        .onAppear{
            viewModel.downloadimage(serverId: imageInfo.server ?? "", photoId: imageInfo.id ?? "", secret: imageInfo.secret ?? "", resolution: "b")
        }
    }
}

struct DetailedImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedImageView(imageInfo: PhotosData(id: "", owner: "", secret: "", server: "", farm: 0, title: "", isPublic: 0, isFriend: 0, isFamily: 0))
    }
}
