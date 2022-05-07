//
//  ProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct ProfileView: View {
    
    let userId: String
    
    @State private var user: User? = nil
    @State private var posts: [Post] = []
    @State private var followers: [User] = []
    
    @State private var isUserLoaded = false
    @State private var isPostsLoaded = false
    @State private var isFollowersLoaded = false

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    VStack(alignment: .leading) {
                        Text(isUserLoaded ? user!.displayName : "---")
                            .fontWeight(.bold)
                        Text(isUserLoaded ? user!.userName : "---")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                Text(isUserLoaded ? user!.introduction : "---")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Text(isUserLoaded ? "\(user!.followings.count)" : "-")
                    Text("followings")
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                    Text(isFollowersLoaded ? "\(self.followers.count)" : "-")
                    Text("followers")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Divider()
                
                if !isPostsLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    ForEach(posts) { post in
                        PostRow(post: post, isNavLinkDisable: true)
                            .listRowSeparator(.hidden)
                    }
                }
            }
        }
        
        .onAppear {
            FireUser.read(id: userId) { user in
                if let user = user {
                    withAnimation {
                        self.user = user
                        self.isUserLoaded = true
                    }
                }
            }
            FirePost.readPosts(userId: userId) { posts in
                withAnimation {
                    self.posts = posts
                    self.isPostsLoaded = true
                }
            }
            FireUser.readFollowers(id: userId) { users in
                withAnimation {
                    self.followers = users
                    self.isFollowersLoaded = true
                }
            }
        }
        
        .navigationTitle(user != nil ? user!.displayName : "profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if userId == FireAuth.userId() {
                    Menu {
                        Button(action: {
                            
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
                    Button("follow") {
                        FireUser.follow(userId: userId)
                    }
                }
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(userId: "jfaldjflakgjjg")
//    }
//}
