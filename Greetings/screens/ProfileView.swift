//
//  ProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI
import SlidingTabView

struct ProfileView: View {
    
    private let showUserId: String
    @State private var navTitle = "---"
    @State private var selection = 0
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }

    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                ProfileDetailSection(showUserId: showUserId)
                
                SlidingTabView(selection: $selection, tabs: ["posts", "likes"])
                
                if selection == 0 {
                    ProfilePostsSection(postedBy: showUserId)
                } else {
                    ProfileLikesSection(likedBy: showUserId)
                }
                
            }
        }
        .onAppear(perform: load)
                
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if showUserId == FireAuth.userId() {
                    ProfileMenu()
                } else {
                    FollowButton(showUserId: showUserId)
                }
            }
        }
    }
    
    private func load() {
        FireUser.readUser(userId: showUserId) { user in
            if let user = user {
                self.navTitle = user.displayName
            }
        }
    }
}
