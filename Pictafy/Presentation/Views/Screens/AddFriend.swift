//
//  AddFriend.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-14.
//

import SwiftUI

struct AddFriend: View {
    @State var username: String = ""
    @State private var showingAlert = false
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    func sendRequest(){
        print("success!")
        showingAlert = true
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Textbox(header: "Enter Friend's Username", text: $username, placeholder: Text("Enter Username"))
                PictafyButton(text: "Send Request", action: { sendRequest() })
                    .padding(.top,20)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Friend Request Sent!"),dismissButton: .default(Text("OK")))
                    }
            }.padding().padding()
            .navigationTitle("Add Friend")
        }
    }
}

struct AddFriend_Previews: PreviewProvider {
    static var previews: some View {
        AddFriend()
    }
}