//
//  FirstView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject private var postsViewModel: PostsForFeedViewModel
    
    @State private var isShowSheet = false
    
    init() {
        postsViewModel = PostsForFeedViewModel(userId: FireAuth.userId())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(postsViewModel.posts) { post in
                        PostRow(showPost: post)
                    }
                }
            }
            
            .sheet(isPresented: $isShowSheet) {
                CreatePostView()
            }
            
            .navigationTitle("home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ProfileView(showUserId: FireAuth.userId())) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action :{
                        isShowSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct FirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstView()
//    }
//}
