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
    @FocusState private var hideKeyboard: Bool
    var body: some View {
        NavigationView {
            ZStack() {
            Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.bottom)
                VStack{
                        if photosVm.dataArray.isEmpty || photosVm.dataArray == nil{
                            TextCustomPhotoApp(text: "Find Flickr photos by \nsearching names in the \nsearch bar below", fontName: "Poppins-Regular", fontSize: 18, fontColor: .black.opacity(0.60), alignment: .center, lineLimit: 3)
                                .padding(.top, 100)
                        }else {
                        ScrollView{
                            LazyVGrid(columns: columns,spacing: 14){
                            ForEach(photosVm.dataArray, id: \.hashValue) { item in
                            NavigationLink {
                                    DetailedImageView(imageInfo: item)
                                } label: {
                                        CustomImage(imageInfo: item)
                                }
                                .onAppear{
                                    if item.hashValue == photosVm.dataArray.last?.hashValue{
                                        photosVm.fetchDataInfinity(perPage: 40, newSearch: true)
                                    }
                                }
                                .simultaneousGesture(
                                TapGesture()
                                    .onEnded({ _ in
                                        hideKeyboard = false
                                    })
                                )
                            }
                        }
                    }
                }
                   
                }
                CustomSearchBar(textInput: $photosVm.searchText)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .onChange(of: photosVm.searchText, perform: { newValue in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if newValue.isEmpty{
                                photosVm.dataArray = []
                            }else {
                                photosVm.fetchDataInfinity(perPage: 40, newSearch: false)
                            }
                        }
                    })
                    .focused($hideKeyboard)
                    .padding(.bottom,5)
            }
            .navigationTitle("Photos Challenge")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}
