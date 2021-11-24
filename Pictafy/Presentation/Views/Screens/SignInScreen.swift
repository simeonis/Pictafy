
//
//  SignInView.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-10.
//

import SwiftUI

struct SignInScreen: View {
    //For hiding/showing the password:
    //Two TextFields , change SecureField opacity and show/hide a Text
    //A known issue for this approach: when password is shown, SecureField has 0.0 opacity, so input cursor is not visible. But users can still keep typing without losing keyboard focus
    
    let placeholder: String = "Enter Password"
       @State private var showText: Bool = false
       @State var text: String = ""
       @State var username: String = ""
       var onCommit: (()->Void)?
       
       var body: some View {
        VStack(alignment: .leading, content: {
            
            Text("Log in")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                
            Text("Username")
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(.gray)
                TextField("Username", text: $username)
            
                    
            }.padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(self.username != "" ? Color(.blue) : Color(.gray))
            .foregroundColor(.clear))
            .background(Color.white
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
                
                
              )
            
            Text("Password")
            
            HStack {
             Button(action: {
                 showText.toggle()
             }, label: {
                 Image(systemName: showText ? "eye.slash.fill" : "eye.fill")
             })
             .accentColor(.secondary)
                
             ZStack {
                 
                SecureField(placeholder, text: $text, onCommit: {
                    onCommit?()
                })
                .opacity(showText ? 0 : 1)
                
                if showText {
                    HStack {
                        Text(text)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                }
            }
               
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(self.text != "" ? Color(.blue) : Color(.gray))
            .foregroundColor(.clear))
            .background(Color.white
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
                
              )
            
            Button(action:  {
                
            }){
                Text("Log in")
                    .foregroundColor(.white)
                    .background(Color.blue)
            }
 
        }).padding()
//        .navigationBarBackButtonHidden(true)
//        .padding(.top, -208)

       }
   }

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}

