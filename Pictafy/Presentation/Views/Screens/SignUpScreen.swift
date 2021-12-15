//
//  SignUpScreen.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-23.
//

import SwiftUI

struct Alerts: Identifiable {
    var id: String { name }
    let name: String
}

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
    @State private var selectedAlert: Alerts?
    
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
        
            Textbox(header: "Full name", text: $fullname, placeholder: Text("Full name"))
            
            Textbox(header: "Username", text: $username, placeholder: Text("Username"))
            
            Textbox(header: "Email", text: $email, placeholder: Text("Email"))
            
            ToggleTextbox(header: "Enter Password", action: {showText.toggle()}, text: $password, showText: showText, placeholder: "Enter Password")
            
            ToggleTextbox(header: "Re-Enter Password", action: {showText2.toggle()}, text: $repassword, showText: showText2, placeholder: "Re-Enter Password")
            
            SignInSignUpButton(action: {
                if username == "" || fullname == "" || email == "" || password == "" || repassword == "" {
                    selectedAlert = Alerts(name: "Please fill out all fields")
                    
                }
                if password != repassword{
                    selectedAlert = Alerts(name: "Passwords must match")                }
                createAccount()
                
            }
               , text: "Sign up")
            
            HStack{
                Text("Already have an account?")
                Button(action:  {
                    _selection = 1
                }){
                    Text("Sign in")
                        .foregroundColor(.ui.primaryColor)
                        .fontWeight(.bold)
                }
            } .frame(width: UIScreen.main.bounds.width - 60, height: 70,alignment: .bottom )
            
        }).padding().padding()

        .alert(item: $selectedAlert) { show in
                    Alert(title: Text(show.name), dismissButton: .cancel())
                }
        
        .navigationBarBackButtonHidden(true)
        .padding(.bottom,100)
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
