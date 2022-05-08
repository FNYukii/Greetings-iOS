//
//  ProfileLikesSection.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct ProfileLikesSection: View {
    
    @ObservedObject private var postsLikedByUserViewModel: PostsLikedByUserViewModel
    @State private var isNavLinkActive = false
    @State private var openUserId = ""
    
    init(likedBy: String) {
        self.postsLikedByUserViewModel = PostsLikedByUserViewModel(userId: likedBy)
    }
    
    var body: some View {
        VStack {
            if !postsLikedByUserViewModel.isLoaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ForEach(postsLikedByUserViewModel.posts) { post in
                    PostRow(showPost: post, isNavLinkActive: $isNavLinkActive, openUserId: $openUserId)
                }
            }
        }
    }
}
