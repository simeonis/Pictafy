//
//  CreatePostScreen.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-14.
//

import SwiftUI
import MapKit

struct CreatePostScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var locationService : LocationService
    
    var image : UIImage
    
    //remove this later
    //let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 43.46921422071481, longitude: -79.69997672872174)
    @State var post_name : String = ""
    @State var description : String = ""
    @State var newTag : String = ""
    @State var tags : [String] = []
    @State var tagError : String = ""
    @State var error : String = ""
    
    var body: some View {
        ZStack{
            Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
  
            VStack{
                Form{
                    if(self.error != ""){
                        Text(error)
                            .foregroundColor(Color.red)
                            .listRowBackground(Color.clear)
                    }
                    TextField("", text: $post_name)
                        .modifier(PlaceholderStyle(showPlaceHolder: self.post_name.isEmpty, placeholder: "Title"))
                        .listRowBackground(
                            Rectangle()
                                .background(BlurView(style: .systemUltraThinMaterialLight))
                                .cornerRadius(20, corners: [.topLeft, .topRight])
                                .opacity(0.17)
                                .shadow(color: Color.black.opacity(0.5), radius: 5.0, x: 4, y: 4)
                                .shadow(color: Color.gray.opacity(0.5), radius: 10.0, x: 8, y: 8)
                        )
                        .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .font(Font.system(size: 14))
      
                       
                 
                        TextEditor(text: $description)
                            .modifier(PlaceholderStyle(showPlaceHolder: self.description.isEmpty, placeholder: "Description"))
                            .listRowBackground(
                                Rectangle()
                                    .background(BlurView(style: .systemUltraThinMaterialLight))
                                    .opacity(0.25)
                                    .shadow(color: Color.black.opacity(0.5), radius: 5.0, x: 4, y: 4)
                                    .shadow(color: Color.gray.opacity(0.5), radius: 10.0, x: 8, y: 8)
                            )
                            .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                            .font(Font.system(size: 14))
                    
                    VStack{
                        if(self.tagError != ""){
                            Text(tagError)
                            .foregroundColor(Color.red)
                            .listRowBackground(Color(red: 0, green: 0, blue: 0, opacity: 0.1))
                        }
                        
                        HStack{
                        
                            TextField("", text: $newTag, onCommit: {
                                  addTag(tag: newTag)
                            })
                             .modifier(PlaceholderStyle(showPlaceHolder: self.newTag.isEmpty, placeholder: "Add Tags"))
                             .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                             .font(Font.system(size: 14))
         
                              Spacer()
                              Image(systemName: "plus.circle")
                              .foregroundColor(.black)
                              .onTapGesture {
                                  addTag(tag: newTag)
                              }
                        }//HStack
                        .background(Color.clear)
                        .frame(minWidth: 100, maxWidth: .infinity)
                        
                        TagCloudView(tags: self.tags)
            
                         .onChange(of: newTag, perform: { value in
                             if value.contains(",") {
                                 newTag = value.replacingOccurrences(of: ",", with: "")
                                 addTag(tag: newTag)
                             }
                          })
                    }
                    .listRowBackground(
                        Rectangle()
                            .background(BlurView(style: .systemUltraThinMaterialLight))
                            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                            .opacity(0.2)
                            .shadow(color: Color.black.opacity(0.5), radius: 5.0, x: 4, y: 4)
                            .shadow(color: Color.gray.opacity(0.5), radius: 10.0, x: 8, y: 8)
                            
                    )
                    .padding(0)
                    

                }//form
                .frame(width: 320, height: 300)
                .padding(.horizontal, 10)
                .background(Color.clear)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.5), radius: 5.0, x: 4, y: 4)
                .shadow(color: Color.gray.opacity(0.5), radius: 10.0, x: 8, y: 8)
                
            
                
                //Submit Button
                HStack{
                    Spacer()
                    Button(action: {self.postAction()} ){
                        Text("Post")
                            .padding(.horizontal, 60)
                            .padding(.vertical, 15)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .foregroundColor(Color.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.ui.primaryColor,Color.ui.blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.5), radius: 5.0, x: 4, y: 4)
                    Spacer()
                }//HStack
                //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                //.listRowInsets(EdgeInsets())
                //.listRowBackground(Color.clear)
        
                }//VStack
                .padding(20)
                //.padding(.top, 0)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear

                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }

        }//ZStack
        .navigationBarHidden(true)
        
    }//Body
    
    func addTag(tag : String){
        if(tagIsValid(tag: tag)){
            tags.append(tag.lowercased())
            self.newTag = ""
            self.tagError = ""
        }
    }
    
    private func tagIsValid(tag : String) -> Bool{
        let lTag = tag.lowercased()
        if(tag == ""){
            self.tagError = "Can't add empty tag"
            return false
            
        }
        else if (tags.contains(lTag)){
            self.tagError = "Tag already added"
            return false
        }
        else{
            return true
        }
    }
    
    func postAction(){
        print("Posted")
        if(self.post_name != "" && self.description != ""){
            self.error = ""
            
            let imgDescriptor = "\(UUID.init())\(self.post_name)"
            
            print(imgDescriptor)
            
            if locationService.currentLocation != nil {
                let coordinate = locationService.currentLocation!.coordinate
                
    
                let hash = fireDBHelper.getGeoHash(location: coordinate)

            
                let postData = PostData(
                    name: self.post_name,
                    description: self.description,
                    geoHash: hash,
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude,
                    imageURL: "images/\(imgDescriptor).jpg"
          
                )
                
                fireDBHelper.insertPost(postData: postData)
                fireDBHelper.uploadImage(image: image, descriptor: imgDescriptor)
            }
        }
        else{
            self.error = "Name and Description can't be null"
        }
    }
}
