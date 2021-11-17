//
//  SettingScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-15.
//

import SwiftUI

struct SettingScreen: View {
    // MARK: UI Variables
    let primaryColor = Color(red: 21/255, green: 27/255, blue: 31/255)
    let secondaryColor = Color.white
    let backgroundColor = Color.orange
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let aspectRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
    
    // MARK: Functionality Variables
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    @State var fullname : String = "Richard Smith"
    @State var username : String = "Richard94"
    @State var email : String = "richard94@gmail.com"
    @State var notificationOn : Bool = true
    
    func signOut() {
        // TO-DO
    }
    
    func deleteAcc() {
        // TO-DO
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.white, backgroundColor]), center: UnitPoint(x: 1/2, y: 2/3), startRadius: 0, endRadius: 225).edgesIgnoringSafeArea(.top)

                Button(action: {}) {
                    ProfileIcon(image: "profile_pic1", editable: true, primary: self.primaryColor, secondary: self.secondaryColor, scale: self.aspectRatio * 0.65)
                }.buttonStyle(ScaleButtonStyle())
            }.frame(height: self.screenHeight / 4)

            Form {
                Section(header: Text("ACCOUNT INFORMATION")) {
                    HStack {
                        Text("Name").bold()
                        Spacer()
                        Text(fullname)
                    }
                    HStack {
                        Text("Username").bold()
                        Spacer()
                        Text(username)
                    }
                    HStack {
                        Text("Email").bold()
                        Spacer()
                        Text(email)
                    }
                    HStack {
                        Text("Password").bold()
                        Spacer()
                        Button(action: {}) {
                            Text("Change Password").foregroundColor(.blue)
                        }
                    }
                } // Section
                
                Section(header: Text("NOTIFICATIONS")) {
                    VStack {
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("Turn \(notificationOn ? "off" : "on") notification?")
                        }
                        Picker("Notification", selection: $notificationOn) {
                            Text("On").tag(true)
                            Text("Off").tag(false)
                        }.pickerStyle(SegmentedPickerStyle())
                    }.padding(4)
                } // Section
                
                VStack(alignment: .leading) {
                    IconButton(action: signOut, text: "SIGN OUT", sysIcon: "circlebadge", primaryColor: .orange, secondaryColor: .white)
                    IconButton(action: deleteAcc, text: "DELETE ACCOUNT", sysIcon: "trash", primaryColor: .red, secondaryColor: .white)
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
            }
        }
        
        .navigationBarItems(trailing:
            Toggle("", isOn: $isDarkMode).toggleStyle(DarkModeToggleStyle())
        )
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
