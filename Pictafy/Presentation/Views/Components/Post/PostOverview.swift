//
//  Post.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-11.
//

import SwiftUI

struct PostOverview: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    var post: PostData
    var scale: CGFloat = 1
    @State private var pressed : Bool = false
    
    var body: some View {
        NavigationLink(destination: PostScreen(post: post), isActive: $pressed) {}
        Button(action: { pressed = true }) {
            Image(uiImage: post.getImage(fb: fireDBHelper))
                .resizable()
                .scaledToFill()
                .frame(width: 256 * scale, height: 512 * scale)
                .clipped()
                .cornerRadius(16)
                .overlay(
                    VStack {
                        HStack {
                            ProfileIcon(image: post.getAvatar(fb: fireDBHelper), scale: 0.5 * scale)
                                .padding(8)
                            Text(post.username).foregroundColor(.white)
                                .bold()
                                .font(.system(size: 20 * scale))
                                .lineLimit(1)
                            Spacer()
                        }
                        .background(Color.black.opacity(0.20))
                        .cornerRadius(16)
                    }, alignment: .topLeading
                )
                .shadow(color: .black.opacity(0.25), radius: 4, x: 6, y: 6)
                .padding(.horizontal)
                .padding(.bottom)
        }
    }
}
