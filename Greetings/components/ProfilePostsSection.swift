//
//  PostsByUserSection.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct ProfilePostsSection: View {
    
    @ObservedObject private var postsByUserViewModel: PostsByUserViewModel
    @State private var isNavLinkActive = false
    @State private var openUserId = ""

    init(showingUserId: String) {
        self.postsByUserViewModel = PostsByUserViewModel(userId: showingUserId)
    }
    
    var body: some View {
        VStack {
            if !postsByUserViewModel.isLoaded {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ForEach(postsByUserViewModel.posts) { post in
                    PostRow(showPost: post, isNavLinkDisable: true, isNavLinkActive: $isNavLinkActive, openUserId: $openUserId)
                        .listRowSeparator(.hidden)
                }
            }
        }
    }
}
