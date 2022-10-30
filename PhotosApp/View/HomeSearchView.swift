//
//  HomeSearchView.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI

struct HomeSearchView: View {
    @StateObject private var photosVm = HomeSearchViewModel()
    let columns:[GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: 1,alignment: nil),
        GridItem(.flexible(minimum: 100), spacing: 1,alignment: nil),
        GridItem(.adaptive(minimum: 100), spacing: 1,alignment: nil),
        ]
    var body: some View {
        NavigationView {
            ZStack() {
            Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.bottom)
                VStack{
                    ScrollView{
                        if photosVm.dataArray.isEmpty{
                            TextCustomPhotoApp(text: "Find Flickr photos by \nsearching names in the \nsearch bar below", fontName: "Poppins-Regular", fontSize: 18, fontColor: .black.opacity(0.60), alignment: .center, lineLimit: 3)
                                .padding(.top, 100)
                        }else {
                            LazyVGrid(columns: columns,spacing: 14){
                            ForEach(photosVm.dataArray, id: \.id) { item in
                                CustomImage(imageInfo: item)
                            }
                        }
                    }
                }
                }
            }
            .navigationTitle("Photos Challenge")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                photosVm.fetchData(perPage: 20, page: 1)
            }
        }
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}
