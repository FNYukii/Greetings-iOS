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
    
    @State private var isUserLoaded = false
    @State private var isPostsLoaded = false

    var body: some View {
        
        ScrollView {
            VStack {
                
                if !isUserLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                if isUserLoaded {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                                .foregroundColor(.secondary)
                            VStack(alignment: .leading) {
                                Text(user != nil ? user!.displayName : "nothing")
                                    .fontWeight(.bold)
                                Text(user != nil ? user!.userName : "nothing")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Text(user != nil ? user!.introduction : "nothing")
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        
                        HStack {
                            Text(user != nil ? "\(user!.followings.count)" : "nothing")
                            Text("followings")
                                .foregroundColor(.secondary)
                                .padding(.trailing)
                            Text(user != nil ? "\(user!.followers.count)" : "nothing")
                            Text("followers")
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                
                if !isPostsLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                if isPostsLoaded {
                    ForEach(posts) { post in
                        PostRow(post: post)
                            .listRowSeparator(.hidden)
                    }
                }
            }
        }
        
        .onAppear {
            FireUser.read(id: userId) { user in
                if let user = user {
                    self.user = user
                    self.isUserLoaded = true
                }
            }
            FirePost.read(userId: userId) { posts in
                self.posts = posts
                self.isPostsLoaded = true
            }
        }
        
        .navigationTitle(user != nil ? user!.displayName : "profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
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
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(userId: "jfaldjflakgjjg")
//    }
//}
