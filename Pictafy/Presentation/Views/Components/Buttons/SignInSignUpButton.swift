//
//  SignInSignUpButton.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-25.
//

import SwiftUI

struct SignInSignUpButton: View {
    var action : () -> Void
    var text : String = "Sign in"
    
    var body: some View {
        HStack{
        Button(action: action) {
            HStack{
                Text(text)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.title2)
                    .padding(.init(.init(top: 10, leading: 20, bottom: 10, trailing: 0)))
                    .textCase(.uppercase)
                  
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(alignment: .leading)
            }
            .frame(width: 190)
        }
        .background( LinearGradient(gradient: Gradient(colors: [Color.ui.primaryColor,Color.ui.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .cornerRadius(100)
            .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
          )
        .padding(.top,20)
        }.frame(width: UIScreen.main.bounds.width - 60,alignment: .trailing )
    }
}


