//
//  PostView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-11.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI
import Firebase
import FirebaseFirestore

struct PostScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    var post: Post

    @State private var hideTag : Bool = false
    @State private var postImage : UIImage? = nil
    @State private var avatarImage : UIImage? = nil
    
    func onLoad() {
        fireDBHelper.getImage(url: post.imageURL) { image in
            postImage = image
        }
        fireDBHelper.getImage(url: post.avatarURL) { image in
            avatarImage = image
        }
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: postImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.vertical)
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    ProfileIcon(image: avatarImage, scale: 0.5)
                    VStack(alignment: .leading) {
                        Text(post.username).foregroundColor(.white)
                            .bold()
                            .font(.system(size: 24))
                            .lineLimit(1)
                        Text(post.name).foregroundColor(.white)
                            .font(.system(size: 18))
                            .lineLimit(1)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .padding(.vertical, 16)
                .offset(x: 0, y: 16)
                .background(Color.black.opacity(0.50))
                .cornerRadius(16)
                .opacity(hideTag ? 0 : 1)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        } // ZStack
        .onTapGesture(perform: {
            withAnimation(.easeInOut(duration: 0.6)) {
                hideTag.toggle()
            }
        })
        .onAppear() { onLoad() }
    }
}
