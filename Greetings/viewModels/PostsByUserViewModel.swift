//
//  PostsByUserViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import Firebase
import SwiftUI

class PostsByUserViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoaded = true
    
    init(userId: String) {
        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error reading Posts posted by \(userId): \(error!)")
                    return
                }
                print("HELLO! Success! Read Posts posted by \(userId). Size: \(snapshot.documents.count)")
                
                var newPosts: [Post] = []
                snapshot.documents.forEach { document in
                    let post = Post(queryDocumentSnapshot: document)
                    newPosts.append(post)
                }
                
                withAnimation {
                    self.posts = newPosts
                    self.isLoaded = true
                }
            }
    }
}
