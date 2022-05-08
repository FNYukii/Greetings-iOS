//
//  FollowButton.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct FollowButton: View {
    
    private let showingUserId: String
    @State private var isFollowing: Bool? = nil
    @State private var isIsfollowingLoaded = false
    
    init(showUserId: String) {
        self.showingUserId = showUserId
    }
    
    var body: some View {
        
        Group {
            if !isIsfollowingLoaded {
                Text("---")
            } else {
                if !isFollowing! {
                    Button("follow") {
                        FireUser.followUser(userId: showingUserId)
                        load()
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(.infinity)
                } else {
                    Button("unfollow") {
                        FireUser.unfollowUser(userId: showingUserId)
                        load()
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
            }
        }
        .animation(.default, value: self.isFollowing)
        .onAppear(perform: load)
    }
    
    private func load() {
        self.isIsfollowingLoaded = false
        FireUser.readUser(userId: FireAuth.userId()) { user in
            if let user = user {
                if user.followings.contains(showingUserId) {
                    self.isFollowing = true
                } else {
                    self.isFollowing = false
                }
                self.isIsfollowingLoaded = true
            }
        }
    }
}
