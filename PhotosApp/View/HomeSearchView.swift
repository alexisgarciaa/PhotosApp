//
//  HomeSearchView.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI

struct HomeSearchView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
            Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.bottom)
                VStack{
                    TextCustomPhotoApp(text: "Find Flickr photos by \nsearching names in the \nsearch bar below", fontName: "Poppins-Regular", fontSize: 18, fontColor: .black.opacity(0.60), alignment: .center, lineLimit: 5)
                }
                .navigationTitle("Photos Challenge")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}
