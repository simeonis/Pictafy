
//
//  SignInView.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-10.
//

import SwiftUI

struct SignInScreen: View {
       @State private var _selection: Int? = nil
       @State private var showText: Bool = false
       @State var username: String = ""
       @State var password: String = ""
       
       var body: some View {
        VStack(alignment: .leading, content: {
            NavigationLink(destination: HomeScreen(), tag: 1, selection: $_selection) {}
            NavigationLink(destination: SignUpScreen(), tag: 2, selection: $_selection) {}
            
            Text("Log in")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                
            Text("Username")
            Textbox(text: $username, placeholder: Text("Username"))
            
            Text("Password")
            ToggleTextbox(action: {showText.toggle()}, text: $password, showText: showText, placeholder: "Enter Password")
            
            SignInSignUpButton(action: {_selection = 1}, text: "Log in")
            
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

