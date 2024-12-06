//
//  RecipeResultsView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/29/24.
//
import SwiftUI

struct RecipeResultsView: View {
    let recipes: [Recipe]

    var body: some View {
        List(recipes) { recipe in
            HStack {
                // Recipe Image
                /*AsyncImage(url: URL(string: recipe.imageURL)) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 50, height: 50)
                         .clipShape(Circle())
                } placeholder: {
                    ProgressView() // Loading placeholder
                }*/
                
                // Recipe Details
                VStack(alignment: .leading) {
                    Text(recipe.title)
                        .font(.headline)
                    Text("Calories: \(recipe.calories)")
                        .font(.subheadline)
                    Text("Fat: \(recipe.fat)")
                        .font(.subheadline)
                    Text("Sugar: \(recipe.sugar)")
                        .font(.subheadline)
                    Text("Protein: \(recipe.protein)")
                        .font(.subheadline)
                    Text("Carbs: \(recipe.carbs)")
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Results")
    }
}
