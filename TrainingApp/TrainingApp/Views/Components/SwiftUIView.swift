//
//  SwiftUIView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/18/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    var image: SpecificList

    var body: some View {
        VStack {
            Text(image.workoutName)
                .font(.title)
                .fontWeight(.bold)
                .cornerRadius(12)
                .padding(.horizontal)
            
            Image(image.vidName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(12)
                .padding(.horizontal)
            
            Text(image.wkDescription)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}
#Preview {
    SwiftUIView()
}
