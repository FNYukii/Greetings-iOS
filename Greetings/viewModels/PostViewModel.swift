//
//  PostViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Foundation
import Firebase

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoaded = true
    
    init(isPinned: Bool) {
        let db = Firestore.firestore()
        db.collection("posts")
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read Posts. Size: \(snapshot.documents.count)")
                
                snapshot.documents.forEach { document in
                    let post = Post(document: document)
                    self.posts.append(post)
                }
                
                self.isLoaded = true
            }
    }
    
}
