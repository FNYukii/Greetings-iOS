//
//  PostRow.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct PostRow: View {
    
    private let showPost: Post
    private let isNavLinkDisable: Bool
    
    @State private var postUser: User? = nil
    @State private var isPostUserLoaded = false
    
    init(showPost: Post, isNavLinkDisable: Bool = false) {
        self.showPost = showPost
        self.isNavLinkDisable = isNavLinkDisable
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                
                NavigationLink(destination: ProfileView(showUserId: showPost.userId)) {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                }
                .disabled(isNavLinkDisable)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(isPostUserLoaded ? postUser!.displayName: "---")
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        Text(isPostUserLoaded ? "@\(postUser!.userName)" : "---")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        HowManyAgoText(from: showPost.createdAt)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Menu {
                            if showPost.userId == FireAuth.userId() {
                                Button(role: .destructive){
                                    FirePost.deletePost(postId: showPost.id)
                                } label: {
                                    Label("delete-post", systemImage: "trash")
                                }
                            } else {
                                Button(action: {
                                    // TODO: Follow
                                }) {
                                    Label("follow \(isPostUserLoaded ? postUser!.userName: "---")", systemImage: "person.fill.badge.plus")
                                }
                                Button(action: {
                                    // TODO: Mute
                                }) {
                                    Label("mute \(isPostUserLoaded ? postUser!.userName: "---")", systemImage: "speaker.slash")
                                }
                                Button(action: {
                                    // TODO: Block
                                }) {
                                    Label("block \(isPostUserLoaded ? postUser!.userName: "---")", systemImage: "nosign")
                                }
                            }
                        } label : {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.secondary)
                                .padding(.vertical, 4)
                        }
                        
                    }
                    
                    Text(showPost.text)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            if !showPost.likedUsers.contains(FireAuth.userId()) {
                                FirePost.likePost(postId: showPost.id)
                            } else {
                                FirePost.unlikePost(postId: showPost.id)
                            }
                        }) {
                            if !showPost.likedUsers.contains(FireAuth.userId()) {
                                Image(systemName: "heart")
                                    .foregroundColor(.secondary)
                            } else {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Text("\(showPost.likedUsers.count)")
                            .foregroundColor(showPost.likedUsers.contains(FireAuth.userId()) ? .red : .secondary)
                            .font(.callout)
                            .padding(.leading, 4)
                    }
                    .padding(.top, 4)
                }
            }
            Divider()
        }
        .padding(.horizontal)
        
        .onAppear(perform: load)
    }
    
    private func load() {
        FireUser.readUser(userId: showPost.userId) { user in
            if let user = user {
                withAnimation {
                    self.postUser = user
                    self.isPostUserLoaded = true
                }
            }
        }
    }
    
    private func HowManyAgoText(from: Date) -> Text {
        let inputDate = from
        
        let secondDiff: Int = (Calendar.current.dateComponents([.second], from: inputDate, to: Date())).second!
        if secondDiff < 1 {
            return Text("now")
        }
        if secondDiff < 60 {
            return Text("\(secondDiff)s")
        }
        
        let minuteDiff = (Calendar.current.dateComponents([.minute], from: inputDate, to: Date())).minute!
        if minuteDiff < 60 {
            return Text("\(minuteDiff)m")
        }
        
        let hourDiff = (Calendar.current.dateComponents([.hour], from: inputDate, to: Date())).hour!
        if hourDiff < 24 {
            return Text("\(hourDiff)h")
        }
        
        let dayDiff = (Calendar.current.dateComponents([.day], from: inputDate, to: Date())).day!
        if dayDiff < 31 {
            return Text("\(dayDiff)d")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY MMMM d")
        return Text(dateFormatter.string(from: from))
    }
}

//struct PostRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRow()
//    }
//}
