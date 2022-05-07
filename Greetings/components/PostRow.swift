//
//  PostRow.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct PostRow: View {
    
    private let post: Post
    @State private var user: User? = nil
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle")
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user != nil ? user!.displayName: "deleted")
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Text(user != nil ? "@\(user!.userName)" : "deleted")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Text("12時間前")
                            .foregroundColor(.secondary)
                        Spacer()
                        Button(action: {
                            // Open menu
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.secondary)
                        }
                    }
                    Text(post.text)
                }
            }
            Divider()
        }
        
        .onAppear {
            let userId = post.userId
            FireUser.read(id: userId) { user in
                if let user = user {
                    self.user = user
                }
            }
        }
        
    }
}

//struct PostRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRow()
//    }
//}
