//
//  ScreenCard.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-06.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct ScreenCard<Content: View>: View {
    @ViewBuilder var content: () -> Content
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 64) {
                // Card Body
                VStack(alignment: .leading, spacing: 32, content: content).padding(.horizontal, 32)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 3 / 4)
            .background(isDarkMode ? Color.black : Color.white)
            .cornerRadius(48)
        }
    }
}
