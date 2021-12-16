//
//  Friend.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-20.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct FriendCard : View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    var friend : Account
    var action : () -> Void = {}
    @State private var avatarImage : UIImage? = nil
    
    func loadData() {
        fireDBHelper.getCurrentAccount() { account in
            fireDBHelper.getImage(url: "images/avatar/\(account.id!)avatar") { image in
                avatarImage = image
            }
        }
    }
    
    var body : some View {
        HStack {
            ProfileIcon(image: avatarImage, scale: 0.5)
            VStack(alignment: .leading, spacing: 4) {
                Text(friend.username).padding(.leading, 16)
                Text(friend.fullName).padding(.leading, 16)
            }
            Spacer()
        }
        .padding(16)
        .background(isDarkMode ? Color(red: 32/255, green: 33/255, blue: 36/255) : Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.25), radius: 4)
        .onAppear() { loadData() }
    }
}
