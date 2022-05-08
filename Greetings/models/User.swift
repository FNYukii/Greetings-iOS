//
//  User.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

struct User: Identifiable {
    let id: String
    let userName: String
    let displayName: String
    let introduction: String
    let icon: String?
    let followings: [String]
    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        self.userName = documentSnapshot.get("userName") as! String
        self.displayName = documentSnapshot.get("displayName") as! String
        self.introduction = documentSnapshot.get("introduction") as! String
        self.icon = documentSnapshot.get("icon") as? String
        self.followings = documentSnapshot.get("followings") as! [String]
    }
}
