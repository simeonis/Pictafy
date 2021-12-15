//
//  SettingScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-15.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    // MARK: UI Variables
    let imageFilter = Color(red: 45/255, green: 45/255, blue: 64/255).opacity(0.15)
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // MARK: Functionality Variables
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    
    @State var passwordError: String = ""
    @State var newPassword: String = ""
    @State var showNewPassword: Bool = false
    
    @State private var id : String = ""
    @State private var fullname : String = "Richard Smith"
    @State private var username : String = "Richie23"
    @State private var email : String = "richard94@gmail.com"
    @State private var isShowingPhotoPicker : Bool = false
    @State private var isShowingPasswordChanger : Bool = false
    @State private var avatarImage : UIImage? = nil
    
    // onAppear
    func loadData() {
        fireDBHelper.getCurrentAccount() { account in
            fullname = account.fullName
            username = account.username
            email = account.email
            id = account.id ?? ""
            fireDBHelper.getImage(url: "images/avatar/\(account.id!)avatar") { image in
                avatarImage = image
            }
        }
    }
    
    func changePassword() {
        fireDBHelper.changePassword(newPassword: newPassword) { success in
            passwordError = success ? "" : "Something went wrong, please try again"
            isShowingPasswordChanger = !success
        }
    }
    
    func logOut() {
        fireDBHelper.logout()
    }
    
    func deleteAccount() {
        fireDBHelper.deleteAccount()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Image Background
            ZStack {
                if (avatarImage != nil) {
                    Image(uiImage: avatarImage!)
                        .resizable()
                        .frame(width: self.screenWidth * 1.33, height: self.screenHeight / 3)
                        .blur(radius: 6)
                        .overlay(Rectangle()
                                    .foregroundColor(imageFilter))
                } else {
                    Image("sample_post")
                        .resizable()
                        .frame(width: self.screenWidth * 1.33, height: self.screenHeight / 3)
                        .blur(radius: 3)
                        .overlay(Rectangle()
                                    .foregroundColor(imageFilter))
                }
            }.frame(width: self.screenWidth, height: self.screenHeight / 4)
            
            // Card
            ScreenCard {
                VStack(alignment: .leading) {
                    Text(fullname)
                        .font(.title3)
                        .padding(.top, 16)
                    Text("@\(username)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 100)
                
                CardFormField(title: "Information") {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Email").padding(.leading, 16)
                        Spacer()
                        Text(email)
                    }
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Password").padding(.leading, 16)
                        Spacer()
                        Button("Change Password", action: {isShowingPasswordChanger = true})
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
                } // CardFormField
                CardFormField(title: "Account") {
                    HStack {
                        Image(systemName: "arrow.right")
                        Button("Logout", action: logOut)
                            .foregroundColor(.blue)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "trash.fill")
                        Button("Delete Account", action: deleteAccount)
                            .foregroundColor(.red)
                            .padding(.leading, 16)
                        Spacer()
                    }
                } // CardFormField
            }.overlay(
                Button(action: { isShowingPhotoPicker = true }) {
                    ProfileIcon(image: avatarImage, editable: true)
                }
                .buttonStyle(ScaleButtonStyle())
                .position(x: 115, y: 5)
            ) // ScreenCard
        } // VStack
        .background(Color.red)
        .edgesIgnoringSafeArea(.vertical)
        .onAppear() { loadData() }
        .sheet(isPresented: $isShowingPhotoPicker){
            PhotoPicker(avatarImage: $avatarImage)
                .onDisappear() {
                    if (avatarImage != nil) {
                        fireDBHelper.uploadImage(image: avatarImage!, descriptor: "images/avatar/\(id)avatar")
                    }
                }
        }
        .sheet(isPresented: $isShowingPasswordChanger) {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    ToggleTextbox(header:"New Password",action: {showNewPassword.toggle()}, text: $newPassword, showText: showNewPassword, placeholder: "Enter New Password")
                    Text(passwordError).foregroundColor(.red)
                }
                PictafyButton(text: "Confirm", action: { changePassword() })
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }.padding()
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
