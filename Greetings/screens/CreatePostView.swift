//
//  CreateView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct CreatePostView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("hello-world", text: $text)
            }
            
            .navigationTitle("new-post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action :{
                        FirePost.createPost(text: text)
                        dismiss()
                    }) {
                        Text("publish")
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct CreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePostView()
//    }
//}
