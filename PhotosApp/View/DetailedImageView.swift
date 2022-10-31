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
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            VStack(alignment: .leading){
                Button {
                    openURL((URL(string:"https://live.staticflickr.com/\(imageInfo.server ?? "")/\(imageInfo.id ?? "")_\(imageInfo.secret ?? "")_\("b").jpg") ?? URL(string: "https://www.google.com"))!)
                } label: {
                    TextCustomPhotoApp(text: "Open in browser >", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial.opacity(0.7))
                        .cornerRadius(5)
                        
                }
                .padding(.bottom, 5)
                HStack{
                    TextCustomPhotoApp(text: "Owener:", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                    TextCustomPhotoApp(text: imageInfo.owner ?? "", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                }
                
                HStack{
                    TextCustomPhotoApp(text: "Taken at:", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                    TextCustomPhotoApp(text: imageInfo.dateTaken ?? "", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                }
                TextCustomPhotoApp(text: imageInfo.description?.content ?? "Lorem ipsum dolor sit amet deos asd oihsl shjkjj ddjiiue eueuofo soduo soo", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .leading, lineLimit: 4)
                    .padding(.trailing, 150)
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomLeading)
            .padding(.leading, 25)
            .padding(.bottom, 40)
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
        DetailedImageView(imageInfo: PhotosData(id: "", owner: "holasas", secret: "", server: "", farm: 0, title: "", isPublic: 0, isFriend: 0, isFamily: 0, description: Content(content: "holas a todos espero esten bien hola team holas team"),dateTaken: "holas mundo"))
    }
}
