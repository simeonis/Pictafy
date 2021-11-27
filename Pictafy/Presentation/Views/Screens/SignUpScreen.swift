//
//  SignUpScreen.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-23.
//

import SwiftUI

struct SignUpScreen: View {
    let placeholder: String = "Enter Password"
    @State private var _selection: Int? = nil
    @State private var showText: Bool = false
    @State private var showText2: Bool = false
    @State var fullname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    var onCommit: (()->Void)?
    
    var body: some View {
        VStack(alignment: .leading, content: {
            NavigationLink(destination: SignInScreen(), tag: 1, selection: $_selection) {}
            NavigationLink(destination: SignInScreen(), tag: 2, selection: $_selection) {}
            
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            
           
            Textbox(text: $fullname, placeholder: Text("Full name"))
            
           
            Textbox(text: $username, placeholder: Text("Username"))
            
           
            Textbox(text: $email, placeholder: Text("Email"))

            
            ToggleTextbox(action: {showText.toggle()}, text: $password, showText: showText, onCommit: onCommit, placeholder: "Enter Password")

        
            ToggleTextbox(action: {showText2.toggle()}, text: $repassword, showText: showText2, onCommit: onCommit, placeholder: "Re-Enter Password")
            
            SignInSignUpButton(action: {_selection = 1}, text: "Sign up")
            
            HStack{
                Text("Already have an account?")
                Button(action:  {
                    _selection = 2
                }){
                    Text("Sign in")
                        .foregroundColor(.ui.primaryColor)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            } .frame(width: UIScreen.main.bounds.width - 60, height: 200,alignment: .bottom )
            
        }).padding().padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
