//
//  Post.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Foundation
import Firebase

struct Post: Identifiable {
    var id: String = ""
    var createdAt: Date = Date()
    var userId: String = ""
    var text: String = ""
    var images: [String] = []
    var likedUsers: [String] = []
    
    init(queryDocumentSnapshot: QueryDocumentSnapshot? = nil, documentSnapshot: DocumentSnapshot? = nil) {
        if let queryDocumentSnapshot = queryDocumentSnapshot {
            self.id = queryDocumentSnapshot.documentID
            self.createdAt = (queryDocumentSnapshot.get("createdAt") as! Timestamp).dateValue()
            self.userId = queryDocumentSnapshot.get("userId") as! String
            self.text = queryDocumentSnapshot.get("text") as! String
            self.images = queryDocumentSnapshot.get("images") as! [String]
            self.likedUsers = queryDocumentSnapshot.get("likedUsers") as! [String]
        }
        
        if let documentSnapshot = documentSnapshot {
            self.id = documentSnapshot.documentID
            self.createdAt = (documentSnapshot.get("createdAt") as! Timestamp).dateValue()
            self.userId = documentSnapshot.get("userId") as! String
            self.text = documentSnapshot.get("text") as! String
            self.images = documentSnapshot.get("images") as! [String]
            self.likedUsers = documentSnapshot.get("likedUsers") as! [String]
        }
    }
}
