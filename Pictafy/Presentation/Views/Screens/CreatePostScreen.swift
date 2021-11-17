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
    @State var newTag : String = ""
    @State var tags : [String] = []
    @State var error : String = ""
    
    var body: some View {
        VStack{
            Image("sample_post")
            .resizable()
            .aspectRatio(contentMode: .fit)
            Form{
                Section{
                    TextField("Enter title", text: $post_name)
                    TextField("Description", text: $description)
                    VStack{
                        if(self.error != ""){
                            Text(error)
                                .foregroundColor(Color.red)
                        }
                        HStack{
                            ForEach(tags, id: \.self){ tag in
                                HStack{
                                    Text(tag)
                                    Image(systemName: "xmark.circle")
                                }
                                .font(Font.custom("a", size: 12))
                                .padding(5)
                                .onTapGesture {
                                    tags = tags.filter({ $0 != tag })
                                }
                            }
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                            .cornerRadius(8.0)
                            
                            TextField("Add Tags", text: $newTag, onCommit: {
                                addTag(tag: newTag)
                            })
                            Spacer()
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    addTag(tag: newTag)
                                }
                            
                        }
                        .onChange(of: newTag, perform: { value in
                            if value.contains(",") {
                                newTag = value.replacingOccurrences(of: ",", with: "")
                                addTag(tag: newTag)
                            }
                        })
                    }
                }
                
                HStack{
                    Spacer()
                    Button(action: {self.postAction()} ){
                        Text("Post")
                            .padding(.horizontal, 60)
                            .padding(.vertical, 15)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.ui.primaryColor,Color.ui.blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(50.0)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
            
            }

        }
    }
    
    func addTag(tag : String){
        if(tagIsValid(tag: tag)){
            tags.append(tag.lowercased())
            self.newTag = ""
        }
    }
    
    private func tagIsValid(tag : String) -> Bool{
        let lTag = tag.lowercased()
        if(tag == ""){
            self.error = "Can't add empty tag"
            return false
            
        }
        else if (tags.contains(lTag)){
            self.error = "Tag already added"
            return false
        }
        else{
            return true
        }
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
