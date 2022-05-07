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
                isShowSignInSheet.toggle()
            }
            Button("sign-in") {
                isShowSignUpSheet.toggle()
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
