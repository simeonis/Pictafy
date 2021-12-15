//
//  FriendRequests.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-14.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI
import FirebaseAuth

struct FriendRequests: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var friendSelected : Int = 0
    @State private var friendList : [Account] = []
    // onAppear
    func loadData() {
        fireDBHelper.getCurrentFriendRequests() { friendAccounts in
            friendList = friendAccounts
        }
    }
    
    var body: some View {
            VStack{
                Text("Friend Requests")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                if friendList.count > 0 {
                    List {
                        ForEach(friendList, id: \.self) { friend in
                            Button(action: {}) {
                                FriendRequestCard(friend: friend)
                            }
                        }
                    }
                } else {
                    Text("You currently have no friend requests")
                }
            }
            .onAppear() { loadData() }
        }
}

