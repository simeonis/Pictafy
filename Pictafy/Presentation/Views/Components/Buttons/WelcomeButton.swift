//
//  WelcomeButton.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-03.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct WelcomeButton: View {
    var action : () -> Void
    var text : String = "Sign in"
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.ui.blue)
                .fontWeight(.heavy)
                .font(.title2)
                .padding(.init(.init(top: 10, leading: 0, bottom: 10, trailing: 0)))
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.width - 110)
        }
        .background(Color.white
            .cornerRadius(100)
            .shadow(color: Color.ui.blue, radius: 3, x: 0, y: 2)
          )
        .padding(.top,20)
    }
}


