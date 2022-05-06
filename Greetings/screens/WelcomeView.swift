//
//  WelcomeView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isShowSheet = false
    
    var body: some View {
        Button("sign-in") {
            isShowSheet.toggle()
        }
        
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
