//
//  Post.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Foundation
import Firebase

struct Post: Identifiable {
    let id: String
    let createdAt: Date
    let userId: String
    let text: String
    let images: [String]
    let likedUsers: [String]
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        self.createdAt = (document.get("createdAt") as! Timestamp).dateValue()
        self.userId = document.get("userId") as! String
        self.text = document.get("text") as! String
        self.images = document.get("images") as! [String]
        self.likedUsers = document.get("likedUsers") as! [String]
    }
}
