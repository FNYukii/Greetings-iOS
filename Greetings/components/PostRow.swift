//
//  PostRow.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct PostRow: View {
    
    private let post: Post
    private let isNavLinkDisable: Bool
    @State private var user: User? = nil
    
    init(post: Post, isNavLinkDisable: Bool = false) {
        self.post = post
        self.isNavLinkDisable = isNavLinkDisable
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                
                NavigationLink(destination: ProfileView(userId: post.userId)) {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                }
                .disabled(isNavLinkDisable)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user != nil ? user!.displayName: "---")
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        Text(user != nil ? "@\(user!.userName)" : "---")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        HowManyAgoText(from: post.createdAt)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Menu {
                            if post.userId == FireAuth.userId() {
                                Button(role: .destructive){
                                    FirePost.delete(id: post.id)
                                } label: {
                                    Label("delete-post", systemImage: "trash")
                                }
                            } else {
                                Button(action: {
                                    // TODO: Follow
                                }) {
                                    Label("follow \(post.userId)", systemImage: "person.fill.badge.plus")
                                }
                                Button(action: {
                                    // TODO: Mute
                                }) {
                                    Label("Mute \(post.userId)", systemImage: "speaker.slash")
                                }
                                Button(action: {
                                    // TODO: Block
                                }) {
                                    Label("Block \(post.userId)", systemImage: "nosign")
                                }
                            }
                        } label : {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.secondary)
                                .padding(.vertical, 4)
                        }
                        
                    }
                    
                    Text(post.text)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            if !post.likedUsers.contains(FireAuth.userId()) {
                                FirePost.like(id: post.id)
                            } else {
                                FirePost.unlike(id: post.id)
                            }
                        }) {
                            if !post.likedUsers.contains(FireAuth.userId()) {
                                Image(systemName: "heart")
                                    .foregroundColor(.secondary)
                            } else {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Text("\(post.likedUsers.count)")
                            .foregroundColor(post.likedUsers.contains(FireAuth.userId()) ? .red : .secondary)
                            .font(.callout)
                            .padding(.leading, 4)
                    }
                    .padding(.top, 4)
                }
            }
            Divider()
        }
        .padding(.horizontal)
        
        .onAppear {
            let userId = post.userId
            FireUser.read(id: userId) { user in
                if let user = user {
                    withAnimation {
                        self.user = user
                    }
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
