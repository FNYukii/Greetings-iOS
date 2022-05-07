//
//  SignInView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("email", text: $email)
                TextField("password", text: $password)
            }
            
            .navigationTitle("sign-in")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action :{
                        FireAuth.signIn(email: email, password: password)
                        dismiss()
                    }) {
                        Text("done")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
