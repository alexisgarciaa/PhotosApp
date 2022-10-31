//
//  CustomSearchBar.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI
import Contacts

struct CustomSearchBar: View {
    @Binding var textInput: String
    @Binding var names : [CNContact]
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(lineWidth: 1.25)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: 46)
            .overlay {
                HStack{
                    Menu {
                            ForEach(names,id: \.hashValue) { item in
                                Button {
                                    textInput = item.givenName.capitalized
                                    print(item.givenName)
                                } label: {
                                    Text("\(item.givenName)")
                                }
                            }
                        
                    } label: {
                        BurgerItem()
                    }
                    
                    SearchBarIcons()
                }
            }
            .background(
                Color.white.cornerRadius(5)
                    .shadow(color: Color.gray, radius: 5, x: 3, y: 5)
            )
        }
    @ViewBuilder
    func BurgerItem() -> some View {
        Image("menuBurger")
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.black)
            .frame(width: 17, height: 11)
            .padding(.leading, 15)
    }
    
    @ViewBuilder
    func SearchBarIcons() -> some View {
        TextField("Search", text: $textInput)
            .font(.custom("Poppins-Medium", size: 15))
            .padding(.leading, 15)
        Image(systemName: "line.diagonal")
            .renderingMode(.template)
            .font(.system(size: 30, weight: .thin))
            .rotationEffect(Angle(degrees: -45))
            .padding(.trailing, -5)
        Image(systemName: "magnifyingglass")
            .renderingMode(.template)
            .frame(width: 10, height: 10)
            .padding(.trailing, 20)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(textInput: .constant(""), names: .constant([CNContact()]))
    }
}
