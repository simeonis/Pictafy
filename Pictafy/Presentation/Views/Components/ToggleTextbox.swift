//
//  ToggleTextbox.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-25.
//

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
        //Two TextFields; change SecureField opacity and show/hide a Text
        //A known issue for this approach: when password is shown, SecureField has 0.0 opacity, so input cursor is not visible, but users can still keep typing without losing keyboard focus
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
