//
//  ProfileIcon.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-15.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct ProfileIcon: View {
    var image : UIImage? = nil
    var editable : Bool = false
    var primary : Color = Color.black
    var secondary : Color = Color.white
    var scale : CGFloat = 1.0
    var border : Bool = false
    var borderThickness : Int = 8
    
    private var profileRadius : CGFloat {
        return 128 * scale
    }
    
    private var cornerRadius : CGFloat {
        return 64 * scale
    }
    
    private var posX : CGFloat {
        return self.profileRadius * CGFloat(cosf(Float.pi / 4.0))
    }
    
    private var posY : CGFloat {
        return self.profileRadius * CGFloat(sinf(Float.pi / 4.0))
    }
    
    var body : some View {
        ZStack {
            if (border) {
                Circle()
                    .frame(width: self.profileRadius + CGFloat(self.borderThickness), height: self.profileRadius + CGFloat(self.borderThickness))
                    .foregroundColor(primary)
            }
            // Invalid Profile Image
            if (image == nil) {
                Circle()
                    .frame(width: self.profileRadius, height: self.profileRadius)
                    .foregroundColor(.white)
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.profileRadius, height: self.profileRadius)
                    .foregroundColor(.blue)
            }
            // Valid Profile Image
            else {
                Circle()
                    .frame(width: self.profileRadius, height: self.profileRadius)
                    .foregroundColor(.black)
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.profileRadius, height: self.profileRadius)
                    .foregroundColor(.blue)
                    .cornerRadius(self.cornerRadius)
            }
            
            if (editable) {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 40 * scale, height: 40 * scale)
                    .padding(.leading, self.posX)
                    .padding(.top, self.posY)
                
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32 * scale, height: 32 * scale)
                    .foregroundColor(primary)
                    .padding(.leading, self.posX)
                    .padding(.top, self.posY)
            }
        }
    }
}
