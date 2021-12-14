//
//  SignUpScreen.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-23.
//

import SwiftUI

struct SignUpScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var _selection: Int? = nil
    @State private var showText: Bool = false
    @State private var showText2: Bool = false
    @State var fullname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    
    func createAccount() {
        self.fireDBHelper.createAccount(email: email, password: password) { success in
            if (success) {
                self.fireDBHelper.insertAccount(newAccount: Account(fullName: self.fullname, username: self.username, email: self.email))
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
          
            NavigationLink(destination: SignInScreen(), tag: 1, selection: $_selection) {}
            
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
        
            Textbox(text: $fullname, placeholder: Text("Full name"))
            
            Textbox(text: $username, placeholder: Text("Username"))
            
            Textbox(text: $email, placeholder: Text("Email"))
            
            ToggleTextbox(action: {showText.toggle()}, text: $password, showText: showText, placeholder: "Enter Password")
            
            ToggleTextbox(action: {showText2.toggle()}, text: $repassword, showText: showText2, placeholder: "Re-Enter Password")
            
            SignInSignUpButton(action: createAccount, text: "Sign up")
            
            HStack{
                Text("Already have an account?")
                Button(action:  {
                    _selection = 1
                }){
                    Text("Sign in")
                        .foregroundColor(.ui.primaryColor)
                        .fontWeight(.bold)
                }
            } .frame(width: UIScreen.main.bounds.width - 60, height: 200,alignment: .bottom )
            
        }).padding().padding()
        .navigationBarBackButtonHidden(true)
        .onReceive(fireDBHelper.$signUpSuccess) { success in
            if success{
                 _selection = 1

            }

        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
