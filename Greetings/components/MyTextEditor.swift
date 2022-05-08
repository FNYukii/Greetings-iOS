//
//  MyTextEditor.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct MyTextEditor: View {
    
    let hint: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(minHeight: 80)
            Text(hint)
                .foregroundColor(Color(UIColor.placeholderText))
                .opacity(text.isEmpty ? 1 : 0)
                .padding(.top, 8)
                .padding(.leading, 5)
        }
    }
}
