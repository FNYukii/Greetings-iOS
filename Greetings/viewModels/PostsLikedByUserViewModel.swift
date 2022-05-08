//
//  PostsLikedByUserViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import Firebase
import SwiftUI

class PostsLikedByUserViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoaded = false
    
    init(userId: String) {
        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("likedUsers", arrayContains: userId)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error reading Posts liked by \(userId). Error: \(error!)")
                    return
                }
                print("HELLO! Success! Read Posts liked by \(userId). Size: \(snapshot.documents.count)")
                
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
