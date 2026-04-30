//
//  HomePage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.0, green: 0.1, blue: 0.7), Color.teal.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 24) {
                Spacer()

                Image("HomeLogo-noBackground")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .shadow(radius: 10)

                Text("Welcome to Phesian")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Train smarter. React faster.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                Spacer()
            }
        }
    }
}

#Preview {
    HomePage()
}
