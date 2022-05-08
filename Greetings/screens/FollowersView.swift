//
//  FollowersView.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct FollowersView: View {
    
    private let showUserId: String
    
    @State private var followers: [User] = []
    @State private var isFollowersLoaded = false
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }
    
    var body: some View {
        Group {
            
            if !isFollowersLoaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            if isFollowersLoaded && followers.isEmpty {
                Text("no-followers")
                    .foregroundColor(.secondary)
            }
            
            if isFollowersLoaded && !followers.isEmpty {
                ScrollView {
                    VStack {
                        ForEach(followers) { user in
                            UserRow(showUser: user)
                        }
                    }
                }
            }
        }
        
        .onAppear {
            FireUser.readFollowers(userId: showUserId) { users in
                withAnimation {
                    self.followers = users
                    self.isFollowersLoaded = true
                }
            }
        }
        
        .navigationTitle("followers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct FollowersView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowersView()
//    }
//}
