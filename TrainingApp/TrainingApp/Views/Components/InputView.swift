//
//  InputView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/15/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 15))
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(7)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 15))
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(7)
            }
        }
    }
}
#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
