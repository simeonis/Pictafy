//
//  Account.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-03.
//

import Foundation
import FirebaseFirestoreSwift

struct Account : Codable, Identifiable, Hashable{
    @DocumentID var id : String? = UUID().uuidString
    var image : String = ""
    var fullName : String = ""
    var username : String = ""
    var email : String = ""
    var posts : [String] = []
    var friends : [String] = []
    var friendRequests : [String] = []
    var dateCreated : Date = Date()
    
    init() {}

    init(fullName: String, username: String, email: String){
        self.fullName = fullName
        self.username = username
        self.email = email
        self.dateCreated = Date()
    }
    
    init(id: String, image: String, fullName: String, username: String, email: String, posts: [String], friends: [String], requests: [String], dateCreated: Date) {
        self.id = id
        self.image = image
        self.fullName = fullName
        self.username = username
        self.email = email
        self.posts = posts
        self.friends = friends
        self.friendRequests = requests
        self.dateCreated = dateCreated
    }
    
    // initializer used to parse JSON objects into Swift objects
    init(id : String, dictionary: [String: Any]){
        let image = dictionary["image"] as? String ?? ""
        let fullName = dictionary["fullName"] as? String ?? "Unknown"
        let username = dictionary["username"] as? String ?? "Unknown"
        let email = dictionary["email"] as? String ?? "@mail.com"
        let posts = dictionary["posts"] as? Array<String> ?? []
        let friends = dictionary["friends"] as? Array<String> ?? []
        let friendRequests = dictionary["friendRequests"] as? Array<String> ?? []
        let dateCreated = dictionary["dateCreated"] as? Date ?? Date.init()
        
        self.init(id: id, image: image, fullName: fullName, username: username, email: email, posts: posts, friends: friends, requests: friendRequests, dateCreated: dateCreated)
    }
}

