//
//  SignInView.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-10.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct SignInScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var _selection: Int? = nil
    @State private var showText: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    @State var shouldShowHome = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading, content: {
            NavigationLink(destination: HomeScreen(), isActive: $shouldShowHome){}
            NavigationLink(destination: SignUpScreen(), tag: 2, selection: $_selection) {}
            
            Text("Log in")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Textbox(header:"Email", text: $email, placeholder: Text("Enter Email"))
            
            ToggleTextbox(header:"Password", action: {showText.toggle()}, text: $password, showText: showText, placeholder: "Enter Password")
            
            SignInSignUpButton(action: {
                if email == "" || password == "" {
                    showingAlert = true
                }
                
                self.fireDBHelper.signIn(email: email, password: password)
            }, text: "Log in")
            
            HStack{
                Text("Don't have an account?")
                Button(action:  {
                    _selection = 2
                }){
                    Text("Sign up")
                        .foregroundColor(.ui.primaryColor)
                        .fontWeight(.bold)
                }
            } .frame(width: UIScreen.main.bounds.width - 60, height: 200,alignment: .bottom )
            
        }).padding().padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Please fill out all fields"), dismissButton: .default(Text("OK")))
        }
        
        .navigationBarBackButtonHidden(true)
        .onReceive(fireDBHelper.$signedIn) { success in
            if success{
                shouldShowHome = true
            }
        }
        .onAppear(){
            fireDBHelper.signUpSuccess = false
        }
    }
}
