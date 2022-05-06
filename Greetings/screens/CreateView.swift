//
//  CreateView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("hello-world", text: $content)
            }
            
            .navigationTitle("new-post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        // TODO: Go back
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action :{
                        // TODO: Publish post
                    }) {
                        Text("publish")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
