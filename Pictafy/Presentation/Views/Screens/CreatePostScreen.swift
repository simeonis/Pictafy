//
//  CreatePostScreen.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-14.
//

import SwiftUI

struct CreatePostScreen: View {
    
    @State var post_name : String = ""
    @State var description : String = ""
    @State var tag : String = ""
    @State var tags : [String] = ["Hello", "Hi", "Yes"]
    
    var body: some View {
        VStack {
//            Image("house.fill")
            Form{
                TextField("Enter title", text: $post_name)
                TextField("Description", text: $description)
                HStack{
                    ForEach(tags, id: \.self){ tag in
                        HStack{ Text(tag)}
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                    }
                    TextField("Tags", text: $tag)
                }
              
            }
            Button(action: {self.postAction()} ){
                Text("Post")
            }
        }.navigationBarHidden(true)
    }
    
    func postAction(){
        print("Posted")
    }
}

struct CreatePostScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostScreen()
    }
}
