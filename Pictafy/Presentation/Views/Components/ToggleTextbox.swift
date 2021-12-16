//
//  ToggleTextbox.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-25.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct ToggleTextbox: View {
    var header: String
    var action : () -> Void
    @Binding var text : String
    var showText: Bool
    var onCommit: (()->Void)?
    var placeholder: String
    
    var body: some View {
        
        //For hiding/showing the password:
        //Two TextFields; change SecureField opacity to show/hide text
        Text(header)
        HStack{
            ZStack {
              SecureField(placeholder, text: $text, onCommit: {
                  onCommit?()
              })
              .opacity(showText ? 0 : 1)
              .disableAutocorrection(true)
              .autocapitalization(.none)

              if showText {
                  HStack {
                      Text(text)
                          .lineLimit(1)
                      Spacer()
                  }
              }
            }
        Button(action: action, label: {
            Image(systemName: showText ? "eye.slash.fill" : "eye.fill")
                }).accentColor(.secondary)
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
