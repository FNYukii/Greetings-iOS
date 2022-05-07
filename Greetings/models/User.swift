//
//  User.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

struct User {
    let id: String
    let userName: String
    let displayName: String
    let introduction: String
    let icon: String?
    let followings: [String]
    
    init(document: DocumentSnapshot) {
        self.id = document.documentID
        self.userName = document.get("userName") as! String
        self.displayName = document.get("displayName") as! String
        self.introduction = document.get("introduction") as! String
        self.icon = document.get("icon") as? String
        self.followings = document.get("followings") as! [String]
    }
}
