//
//  SplashView.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack{
            TextCustomPhotoApp(text: "Photos Challenge", fontName: "Poppins-Bold", fontSize: 22)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}


//MARK: Reusable input

struct TextCustomPhotoApp: View {
    @State var text: String
    @State var fontName: String
    @State var fontSize: CGFloat
    
    init(text: String = "", fontName: String = "Poppins-Regular" , fontSize: CGFloat = 18){
        self.text = text
        self.fontSize = fontSize
        self.fontName = fontName
    }
    
    var body: some View{
        VStack{
            Text(text)
                .font(.custom(fontName, size: fontSize))
        }
    }
}
