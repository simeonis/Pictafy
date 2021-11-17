//
//  IconButton.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//

import SwiftUI

struct IconButton : View {
    var action : () -> Void
    var text : String = "DELETE ACCOUNT"
    var sysIcon : String = "trash"
    var primaryColor : Color = Color.orange
    var secondaryColor : Color = Color.white
    
    var body : some View {
        Button(action: action) {
            HStack {
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)
                        .foregroundColor(secondaryColor)
                        .background(secondaryColor)
                    
                    Image(systemName: sysIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(primaryColor)
                }
                
                Text(text)
                    .bold()
                    .foregroundColor(secondaryColor)
                    .padding(.trailing, 16)
            }.background(primaryColor)
            .cornerRadius(32)
            .shadow(color: .black.opacity(0.25), radius: 2, x: -4, y: 4)
        }.buttonStyle(ScaleButtonStyle())
    }
}
