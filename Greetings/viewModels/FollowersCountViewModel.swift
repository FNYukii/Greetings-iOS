//
//  FollowersCountViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import Firebase
import SwiftUI

class FollowersCountViewModel: ObservableObject {
    
    @Published var followersCount = 0
    @Published var isLoaded = false
    
    init(userId: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("followings", arrayContains: userId)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error reading Users following \(userId). Erorr: \(error!)")
                    return
                }
                print("HELLO! Success! Read Users following \(userId). Size: \(snapshot.documents.count)")
                
                var newUsers: [User] = []
                snapshot.documents.forEach { document in
                    let user = User(documentSnapshot: document)
                    newUsers.append(user)
                }
                
                withAnimation {
                    self.followersCount = newUsers.count
                    self.isLoaded = true
                }
            }
        
    }
    
}
