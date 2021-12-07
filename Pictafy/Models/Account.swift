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
    var image : String = "https://cdn.discordapp.com/attachments/912830780714147861/916359537802506300/blank-profile-picture-973460_640.png"
    var fullName : String = ""
    var username : String = ""
    var email : String = ""
    var dateCreated : Date = Date()
    
    init() {

    }

    init(fullName: String, username: String, email: String){
        self.fullName = fullName
        self.username = username
        self.email = email
        self.dateCreated = Date()
    }
    
    init(image: String, fullName: String, username: String, email: String, dateCreated: Date){
        self.image = "https://cdn.discordapp.com/attachments/912830780714147861/916359537802506300/blank-profile-picture-973460_640.png"
        self.fullName = fullName
        self.username = username
        self.email = email
        self.dateCreated = dateCreated
    }
    
    //initializer used to parse JSON objects into Swift objects
    init?(dictionary: [String: Any]){
        guard let image = dictionary["image"] as? String else{
            return nil
        }
        
        guard let fullName = dictionary["fullName"] as? String else{
            return nil
        }
        
        guard let username = dictionary["username"] as? String else{
            return nil
        }
        
        guard let email = dictionary["email"] as? String else{
            return nil
        }
        
        guard let dateCreated = dictionary["dateCreated"] as? Date else {
            return nil
        }
        
        self.init(image: image, fullName: fullName, username: username, email: email, dateCreated: dateCreated)
    }
}

