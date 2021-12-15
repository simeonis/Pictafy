//
//  FriendScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-20.
//

import SwiftUI

struct FriendScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var friendSelected : Int = 0
    @State private var friendList : [Account] = []
    
    // onAppear
    func loadData() {
        fireDBHelper.getCurrentAccountFriends() { friendAccounts in
            friendList = friendAccounts
        }
    }
    
    var body: some View {
        VStack {
            if friendList.count > 0 {
                List {
                    ForEach(friendList, id: \.self) { friend in
                        Button(action: {}) {
                            FriendCard(friend: friend)
                        }
                    }
                }
            } else {
                Text("You friends list is empty")
            }
        }
        .onAppear() { loadData() }
        .navigationBarTitle("Your Friends", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                NavigationLink(destination: FriendRequests(), label: {
                    Image(systemName: "person.fill")
                })
                NavigationLink(destination: AddFriend(), label: {
                    Image(systemName: "plus")
                })}
        }
    }
}

struct FriendScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendScreen()
    }
}
