//
//  WelcomeView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isShowSignUpSheet = false
    @State private var isShowSignInSheet = false
    
    var body: some View {
        VStack {
            Button("sign-up") {
                isShowSignUpSheet.toggle()
            }
            Button("sign-in") {
                isShowSignInSheet.toggle()
            }
        }
        
        .sheet(isPresented: $isShowSignUpSheet) {
            SignUpView()
        }
        .sheet(isPresented: $isShowSignInSheet) {
            SignInView()
        }
    }
}
