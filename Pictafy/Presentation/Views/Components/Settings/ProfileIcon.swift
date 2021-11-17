//
//  ProfileIcon.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-15.
//

import SwiftUI

struct ProfileIcon: View {
    var image : String = ""
    var editable : Bool = false
    var primary : Color = Color.black
    var secondary : Color = Color.white
    var scale : CGFloat = 1.0
    
    var body : some View {
        ZStack {
            // Invalid Profile Image
            if (UIImage(named: image) == nil) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128 * scale, height: 128 * scale)
                    .foregroundColor(.blue)
            }
            // Valid Profile Image
            else {
                Image(uiImage: UIImage(named: image)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128 * scale, height: 128 * scale)
                    .foregroundColor(.blue)
                    .cornerRadius(64 * scale)
            }
            
            Image(systemName: "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 129 * scale, height: 129 * scale)
                .foregroundColor(primary)
                .font(Font.title.weight(.thin))
            
            if (editable) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30 * scale, height: 30 * scale)
                    .foregroundColor(secondary)
                    .padding(.leading, 128.0 * scale * CGFloat(cosf(Float.pi / 4.0)))
                    .padding(.bottom, 128.0  * scale * CGFloat(sinf(Float.pi / 4.0)))
                
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32 * scale, height: 32 * scale)
                    .foregroundColor(primary)
                    .padding(.leading, 128.0 * scale * CGFloat(cosf(Float.pi / 4.0)))
                    .padding(.bottom, 128.0 * scale * CGFloat(sinf(Float.pi / 4.0)))
            }
        }
    }
}
