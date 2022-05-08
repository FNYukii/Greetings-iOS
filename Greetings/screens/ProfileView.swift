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
    @State private var currentUser: User? = nil
    @State private var followers: [User] = []
    @ObservedObject private var postsByUserViewModel: PostsByUserViewModel
    
    @State private var isShowUserLoaded = false
    @State private var isCurrentUserLoaded = false
    @State private var isFollowersLoaded = false
    
    init(showUserId: String) {
        self.showUserId = showUserId
        self.postsByUserViewModel = PostsByUserViewModel(userId: showUserId)
    }

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading) {
                        Text(isShowUserLoaded ? showUser!.displayName : "---")
                            .fontWeight(.bold)
                        Text(isShowUserLoaded ? showUser!.userName : "---")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                Text(isShowUserLoaded ? showUser!.introduction : "---")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    NavigationLink(destination: FollowingsView(showUserId: showUserId)) {
                        Text(isShowUserLoaded ? "\(showUser!.followings.count)" : "-")
                            .foregroundColor(.primary)
                        Text("followings")
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                    
                    NavigationLink(destination: FollowersView(showUserId: showUserId)) {
                        Text(isFollowersLoaded ? "\(self.followers.count)" : "-")
                            .foregroundColor(.primary)
                        Text("followers")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                if !postsByUserViewModel.isLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    ForEach(postsByUserViewModel.posts) { post in
                        PostRow(showPost: post, isNavLinkDisable: true)
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
                }
                
                if showUserId != FireAuth.userId() && !isCurrentUserLoaded {
                    Text("---")
                }
                
                if showUserId != FireAuth.userId() && isCurrentUserLoaded {
                    if !currentUser!.followings.contains(showUserId) {
                        Button("follow") {
                            FireUser.followUser(userId: showUserId)
                            load()
                        }
                    } else {
                        Button("unfollow") {
                            FireUser.unfollowUser(userId: showUserId)
                            load()
                        }
                    }
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
        FireUser.readUser(userId: FireAuth.userId()) { user in
            if let user = user {
                withAnimation {
                    self.currentUser = user
                    self.isCurrentUserLoaded = true
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

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(userId: "jfaldjflakgjjg")
//    }
//}
