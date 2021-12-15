//
//  Post.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-11.
//

import SwiftUI

struct PostOverview: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper

    var post: Post

    @State private var pressed : Bool = false
    @State private var postImage : UIImage? = nil
    @State private var avatarImage : UIImage? = nil
    var scale: CGFloat = 1
    
    func onLoad() {
        fireDBHelper.getImage(url: post.imageURL) { image in
            postImage = image
        }
        fireDBHelper.getImage(url: post.avatarURL) { image in
            avatarImage = image
        }
    }
    
    
    var body: some View {
        NavigationLink(destination: PostScreen(post: post), isActive: $pressed) {}
        Button(action: { pressed = true }) {

            Image(uiImage: postImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 256 * scale, height: 512 * scale)
                .clipped()
                .cornerRadius(16)
                .overlay(
                    VStack {
                        HStack {
                            ProfileIcon(image: avatarImage, scale: 0.5 * scale)
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
                .onAppear() { onLoad() }
        }
    }
}
