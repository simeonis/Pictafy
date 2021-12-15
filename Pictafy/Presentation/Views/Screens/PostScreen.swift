//
//  PostView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-11.
//

import SwiftUI

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
        ZStack(alignment: .bottomLeading) {
            Image(uiImage: postImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
            HStack {
                ProfileIcon(image: avatarImage, scale: 0.5)

                    .padding(8)
                Text(post.username).foregroundColor(.white)
                    .bold()
                    .font(.system(size: 24))
                    .lineLimit(1)
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.ui.primaryColor,Color.ui.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.9))
            .cornerRadius(16)
            .padding()
            .opacity(hideTag ? 0 : 1)
        } // VStack
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(perform: {
            withAnimation(.easeInOut(duration: 0.6)) {
                hideTag.toggle()
            }
        })
        .onAppear() { onLoad() }
    }
}

