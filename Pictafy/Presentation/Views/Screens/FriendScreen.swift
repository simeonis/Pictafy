//
//  FriendScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-20.
//

import SwiftUI

struct FriendScreen: View {
    @State private var friendSelected : Int = 0
    
    private let friendList =
        [
            Friend(username: "richie87", fullname: "Richard Smith", image: ""),
            Friend(username: "clintBald", fullname: "Baldwin Clint", image: ""),
            Friend(username: "mrsWard", fullname: "Hayley Ward", image: "")
        ]
    
    var body: some View {
        List {
            ForEach(friendList, id: \.self) { friend in
                Button(action: {}) {
                    FriendCard(friend: friend)
                }
            }
        }
        .navigationBarTitle("Your Friends", displayMode: .inline)
    }
}

struct FriendScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendScreen()
    }
}
