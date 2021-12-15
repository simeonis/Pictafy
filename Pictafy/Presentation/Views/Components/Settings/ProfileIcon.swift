//
//  ProfileIcon.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-15.
//

import SwiftUI

struct ProfileIcon: View {
    var image : UIImage? = nil
    var editable : Bool = false
    var primary : Color = Color.black
    var secondary : Color = Color.white
    var scale : CGFloat = 1.0
    var border : Bool = false
    var borderThickness : Int = 8
    
    @ObservedObject private var imageLoader : Loader
    
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
    
    init(
        image : UIImage? = nil,
        editable : Bool = false,
        primary : Color = Color.black,
        secondary : Color = Color.white,
        scale : CGFloat = 1.0,
        border : Bool = false,
        borderThickness : Int = 8,
        path : String ){
        self.image = image
        self.editable = editable
        self.primary = primary
        self.secondary = secondary
        self.scale = scale
        self.border = border
        self.borderThickness = borderThickness
        
        self.imageLoader = Loader(path)
    }
    
    
    var body : some View {
        ZStack {
            if (border) {
                Circle()
                    .frame(width: self.profileRadius + CGFloat(self.borderThickness), height: self.profileRadius + CGFloat(self.borderThickness))
                    .foregroundColor(primary)
            }
            // Invalid Profile Image
     
            if(imageLoader.image != nil){
                    Circle()
                        .frame(width: self.profileRadius, height: self.profileRadius)
                        .foregroundColor(.white)
                    
                Image(uiImage:imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: self.profileRadius, height: self.profileRadius)
                        .foregroundColor(.blue)
                }
                else{
                    Circle()
                        .frame(width: self.profileRadius, height: self.profileRadius)
                        .foregroundColor(.white)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: self.profileRadius, height: self.profileRadius)
                        .foregroundColor(.blue)
                }
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

