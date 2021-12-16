//
//  PostRow.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-11.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct PostRow: View {
    var title : String = "Placeholder"
    var posts : [Post] = []
    var color : Color = Color(UIColor.systemBackground)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.system(size: 20)).bold().padding().padding(.bottom, 0)
            if (posts.count > 0) {
                ScrollViewReader { scrollView in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(posts, id: \.id) { post in
                                PostOverview(post: post, scale: 0.75)
                            }
                        }
                    }
                }
            } else {
                Text("Could not load any posts").padding()
            }
        } // VStack
        .background(color)
    }
}
