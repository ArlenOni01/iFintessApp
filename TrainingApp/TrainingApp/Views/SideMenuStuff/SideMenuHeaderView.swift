//
//  SideMenuHeaderView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/4/24.
//

import SwiftUI

struct SideMenuHeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "house")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.vertical)
                
                Text("Home Page")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    SideMenuHeaderView()
}
