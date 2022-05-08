//
//  ProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct ProfileView: View {
    
    let showUserId: String
    
    @State private var showUser: User? = nil
    @State private var followers: [User] = []
    @ObservedObject private var postsByUserViewModel: PostsByUserViewModel
    
    @State private var isShowUserLoaded = false
    @State private var isFollowersLoaded = false
    
    @State private var isNavLinkActive = false
    @State private var openUserId = ""
    
    init(showUserId: String) {
        self.showUserId = showUserId
        self.postsByUserViewModel = PostsByUserViewModel(userId: showUserId)
    }

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                ProfileDetailSection(showUserId: showUserId)
                
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
        
        .onAppear(perform: load)
        
        .navigationTitle(isShowUserLoaded ? showUser!.displayName : "profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if showUserId == FireAuth.userId() {
                    Menu {
                        Button(action: {
                            // TODO: Edit
                        }) {
                            Label("edit", systemImage: "square.and.pencil")
                        }
                        
                        Button(action: {
                            FireAuth.signOut()
                        }) {
                            Label("sign-out", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title3)
                    }
                } else {
                    FollowButton(showUserId: showUserId)
                }
            }
        }
    }
    
    private func load() {
        FireUser.readUser(userId: showUserId) { user in
            if let user = user {
                withAnimation {
                    self.showUser = user
                    self.isShowUserLoaded = true
                }
            }
        }
        FireUser.readFollowers(userId: showUserId) { users in
            withAnimation {
                self.followers = users
                self.isFollowersLoaded = true
            }
        }
    }
}
