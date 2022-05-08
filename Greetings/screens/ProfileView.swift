//
//  ProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct ProfileView: View {
    
    private let showUserId: String
    @State private var navTitle = "---"
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }

    var body: some View {
        
        ScrollView {
            VStack {
                ProfileDetailSection(showUserId: showUserId)
                ProfilePostsSection(showingUserId: showUserId)
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
