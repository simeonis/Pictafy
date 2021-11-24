
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
       @State private var _selection: Int? = nil
       @State private var showText: Bool = false
       @State var text: String = ""
       @State var username: String = ""
       var onCommit: (()->Void)?
       
       var body: some View {
        VStack(alignment: .leading, content: {
            NavigationLink(destination: HomeScreen(), tag: 1, selection: $_selection) {}
            NavigationLink(destination: SignUpScreen(), tag: 2, selection: $_selection) {}
            Text("Log in")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                
            Text("Username")
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundColor(.gray)
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            }.padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white)
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
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
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
            .stroke(Color.white)
            .foregroundColor(.clear))
            .background(Color.white
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
              )
            HStack{
                
            Button(action: { _selection = 1 }) {
                HStack{
                    Text("Log in")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.title2)
                        .padding(.init(.init(top: 10, leading: 20, bottom: 10, trailing: 0)))
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                      
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
            
            HStack{
                Text("Don't have an account?")
                Button(action:  {
                    _selection = 2
                }){
                    Text("Sign up")
                        .foregroundColor(.ui.primaryColor)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            } .frame(width: UIScreen.main.bounds.width - 60, height: 200,alignment: .bottom )
            
        }).padding().padding()
        .navigationBarBackButtonHidden(true)
       }
   }

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}

