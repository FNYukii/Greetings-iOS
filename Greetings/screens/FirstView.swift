//
//  FirstView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject private var postViewModel = PostViewModel()
    
    @State private var isShowSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(postViewModel.posts) { post in
                    PostRow(post: post)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            
            .sheet(isPresented: $isShowSheet) {
                CreatePostView()
            }
            
            .navigationTitle("home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ProfileView(userId: FireAuth.userId())) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("new") {
                        isShowSheet.toggle()
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
