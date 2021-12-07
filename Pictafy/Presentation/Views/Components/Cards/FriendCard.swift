//
//  Friend.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-20.
//

import SwiftUI

struct FriendCard : View {
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    var friend : Friend
    var action : () -> Void = {}
    
    var body : some View {
        HStack {
            ProfileIcon(scale: 0.5)
            VStack(alignment: .leading, spacing: 4) {
                Text(friend.username).padding(.leading, 16)
                Text(friend.fullname).padding(.leading, 16)
            }
            Spacer()
        }
        .padding(16)
        .background(isDarkMode ? Color(red: 32/255, green: 33/255, blue: 36/255) : Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.25), radius: 4)
    }
}

