//
//  SettingScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-15.
//

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    // MARK: UI Variables
    let imageFilter = Color(red: 45/255, green: 45/255, blue: 64/255).opacity(0.75)
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // MARK: Functionality Variables
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    @State var fullname : String = "Richard Smith"
    @State var username : String = "Richard94"
    @State var email : String = "richard94@gmail.com"
    @State var notificationOn : Bool = true
    
    func changeProfile() {
        // TO-DO
    }
    
    func changePassword() {
        // TO-DO
    }
    
    func toggleNotification(value : Bool) {
        // TO-DO
    }
    
    func logOut() {
        // TO-DO
        fireDBHelper.logout()
    }
    
    func deleteAccount() {
        // TO-DO
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image Background
            ZStack {
                Image("profile_pic1").blur(radius: 6)
                    .overlay(Rectangle()
                                .foregroundColor(imageFilter))
            }.frame(width: self.screenWidth, height: self.screenHeight / 4)
            
            // Card
            ScreenCard {
                VStack(alignment: .leading) {
                    Text(fullname)
                        .bold()
                        .padding(.top, 16)
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Oakville, CAN")
                    }.font(.system(size: 12))
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 100)
                
                CardFormField(title: "Information") {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Email").padding(.leading, 16)
                        Spacer()
                        Text("test@mail.com")
                    }
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Password").padding(.leading, 16)
                        Spacer()
                        Button("Change Password", action: changePassword)
                            .foregroundColor(.blue)
                    }
                } // CardFormField
                CardFormField(title: "Settings") {
                    HStack {
                        Image(systemName: "moon.fill")
                        Text("Dark Mode").padding(.leading, 16)
                        Toggle("", isOn: $isDarkMode)
                            .toggleStyle(DarkModeToggleStyle())
                    }
                    HStack {
                        Image(systemName: "bell.fill")
                        Text("Push Notification").padding(.leading, 16)
                        Toggle("", isOn: $notificationOn)
                            .onChange(of: notificationOn) { value in
                                toggleNotification(value: value)
                            }
                    }
                } // CardFormField
                CardFormField(title: "General") {
                    HStack {
                        Image(systemName: "arrow.right")
                        Button("Logout", action: logOut)
                            .foregroundColor(.blue)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "trash.fill")
                        Button("Delete Account", action: deleteAccount).foregroundColor(.red)
                            .padding(.leading, 16)
                        Spacer()
                    }
                } // CardFormField
            }.overlay(
                Button(action: changeProfile) {
                    ProfileIcon(image: "profile_pic1", editable: true)
                }
                .buttonStyle(ScaleButtonStyle())
                .position(x: 115, y: 5)
            ) // ScreenCard
        } // VStack
        .background(Color.red)
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
