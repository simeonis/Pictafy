//
//  PostData.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Identifiable {
    @DocumentID var id : String? = UUID().uuidString
    var name: String = ""
    var description: String = ""
    var geoHash: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var imageURL: String = ""
    var username: String = ""
    var avatarURL: String = ""
    
    init(){
        
    }
    
    init(name : String, description : String, geoHash : String, latitude : Double, longitude : Double, imageURL : String, username: String, avatarURL: String){
        self.name = name
        self.description = description
        self.geoHash = geoHash
        self.latitude = latitude
        self.longitude = longitude
        self.imageURL = imageURL
        self.username = username
        self.avatarURL = avatarURL
    }
    
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case geoHash
            case latitude
            case longitude
            case imageURL
            case username
            case avatarURL
    }
}

extension Post {
    func getImage(fb : FireDBHelper) -> UIImage {
        return fb.getImage(url: imageURL) ?? UIImage(named: "sample_post")!
    }
    
    func getAvatar(fb : FireDBHelper) -> UIImage? {
        return fb.getImage(url: avatarURL)
    }
}

extension Post: Encodable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(geoHash, forKey: .geoHash)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(username, forKey: .username)
        try container.encode(avatarURL, forKey: .avatarURL)
   }
}

extension Post: Decodable{
    
    //initializer used to parse JSON objects into Swift objects
    init?(dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String else{
            return nil
        }
        
        guard let description = dictionary["description"] as? String else{
            return nil
        }
        
        guard let geoHash = dictionary["geoHash"] as? String else{
            return nil
        }
        
        guard let latitude = dictionary["latitude"] as? Double else {
            return nil
        }
        guard let longitude = dictionary["longitude"] as? Double else {
            return nil
        }
        guard let imageURL = dictionary["imageURL"] as? String else {
            return nil
        }
        
        guard let username = dictionary["username"] as? String else {
            return nil
        }
        
        guard let avatarURL = dictionary["avatarURL"] as? String else {
            return nil
        }
        
        self.init(name: name, description: description, geoHash: geoHash, latitude: latitude, longitude: longitude, imageURL: imageURL, username: username, avatarURL: avatarURL)
    }
}
