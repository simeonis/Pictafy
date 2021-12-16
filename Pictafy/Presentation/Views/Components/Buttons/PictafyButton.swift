//
//  ConfirmButton.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-13.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct PictafyButton: View {
    var text : String = "Placeholder"
    var action : () -> Void
    
    var body: some View {
        HStack{
            Button(action: action) {
                HStack{
                    Text(text)
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                        .padding(8)
                }
            }
            .background( LinearGradient(gradient: Gradient(colors: [Color.ui.primaryColor,Color.ui.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(8)
                .shadow(color: Color.gray, radius: 3, x: 0, y: 2)
              )
        }
    }
}
