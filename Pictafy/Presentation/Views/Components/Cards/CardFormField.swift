//
//  CardFormField.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-06.
//

import SwiftUI

struct CardFormField<Content: View>: View {
    var title: String? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            // Section Header
            if (title != nil) {
                VStack(alignment: .leading) {
                    Text(title!).bold().font(.system(size: 24))
                    Divider()
                }
            }
            // Section Body
            VStack(alignment: .leading, spacing: 16, content: content)
        }
    }
}