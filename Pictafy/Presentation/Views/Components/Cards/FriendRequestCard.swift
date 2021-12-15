//
//  FriendRequestCard.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-14.
//

import SwiftUI
import FirebaseAuth

struct FriendRequestCard: View {
    
    var friend : Account
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var id : String = "9R7h0hAbd2ToZT0WANYA"
    
    func addFriend(){
        
        fireDBHelper.getAccount(){account in
            id = account.id ?? ""
        }
        
        print("ME \(id)")
        print("Friend: \(String(describing: friend.id))")
        
        fireDBHelper.addFriend(userId: id, friendId: friend.id ?? "")
        
        
    }
    
    func declineRequest(){
        fireDBHelper.deleteRequest(userId: id, friendId: friend.id ?? "")
    }
    
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, content: {
                Text(friend.username).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text("Sent a friend request")
            }).padding(.trailing,40)
            
            VStack{
                Button(action: {
                    // fireDBHelper.rejectRequest(id: friend.id ?? "nil")
                    addFriend()
                }) {
                    HStack{
                        Text("Accept")
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                            .padding(8)
                    }
                }
                .background(Color.green)
                .cornerRadius(8)
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
                Button(action: {
                    declineRequest()
                }) {
                    HStack{
                        Text("decline")
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                            .padding(8)
                    }
                }
                .background(Color.red)
                .cornerRadius(8)
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
            }
            
        }
        .padding()
        .padding(.leading,20)
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white)
                    .foregroundColor(.clear))
        .background(Color.white
                        .cornerRadius(10)
                        .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
        )
    }
}

