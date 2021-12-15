//
//  Textbox.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-24.
//

import SwiftUI

struct Textbox: View {
    var header: String
    @Binding var text: String
    var placeholder: Text
    var body: some View {
        Text(header)
        ZStack{
            if text.isEmpty{
                placeholder
                    .foregroundColor(Color(.init(white: 0,alpha:0.2)))
                    .frame(width: UIScreen.main.bounds.width - 92,alignment: .leading)
            }
            HStack{
                TextField("",text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
        }.padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.white)
        .foregroundColor(.clear))
        .background(Color.white
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
        )
    }
}

