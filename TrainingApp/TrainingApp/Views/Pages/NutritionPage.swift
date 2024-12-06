//
//  Nutrition.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/19/24.
//

import SwiftUI

struct NutritionPage: View {
    
    enum type: String, CaseIterable, Identifiable{
        case appetizer, beverage, bread, breakfast, dessert, drink
        case fingerFood = "Finger Food"
        case mainCourse = "Main Course"
        case marinade
        case sideDish = "Side Dish"
        case salad, sauce, snack, soup
        var id: Self { self }
    }
    
    enum diet: String, CaseIterable, Identifiable {
        case none = "None"
        case glutenFree = "Gluten Free"
        case Keto
        case lactoVeg = "Lacto-Vegetarian"
        case lowFODMAP = "Low FODMAP"
        case OvoVegetarian = "Ovo-Vegetarian"
        case paleo, pescatarian, primal
        case Vegetarian, Vegan, Whole30
        var id: Self { self }
    }
    
    enum cuisine: String, CaseIterable, Identifiable {
        case african, asian, american, british, cajun, caribbean, chinese
        case easternEuropean = "Eastern European"
        case European, French, German, Greek, Indian, Irish, Italian, Japanese, Jewish, Korean
        case latinAmerican = "Latin American"
        case Mediterranean, Mexican
        case middleEastern = "Middle Eastern"
        case Nordic, Southern, Spanish, Thai, Vietnamese
        var id: Self { self }
    }
    
    enum intolerances: String, CaseIterable, Identifiable {
        case none = "None"
        case Dairy, Egg, Gluten, Grain, Peanut, Seafood, Sesame, Shellfish, Soy, Sulfite
        case treeNut = "Tree Nut"
        case Wheat
        var id: Self { self }
    }
    
    @State private var mealSelection: type = .appetizer
    @State private var minCalories: Double = 0
    @State private var maxCalories: Double = 1000
    @State private var dietarySelection: diet = .glutenFree
    @State private var cuisineSelection: cuisine = .african
    @State private var intolerancesSelection: intolerances = .Dairy
    
    @State private var minCarbs: Double = 0
    @State private var maxCarbs: Double = 100
    @State private var minProtein: Double = 0
    @State private var maxProtein: Double = 100
    @State private var minFat: Double = 0
    @State private var maxFat: Double = 100
    @State private var minSugar: Double = 0
    @State private var maxSugar: Double = 100
    @State private var totalRecipes: Double = 0
    
    @StateObject private var spoonacularService = SpoonacularService()
    @State private var recipes: [Recipe] = []
    @State private var isLoading = false
    @State private var showResults = false

    func fetchFilteredRecipes() {
        isLoading = true
        spoonacularService.fetchRecipes(
            type: mealSelection.rawValue,
            cuisine: cuisineSelection.rawValue,
            diet: dietarySelection == .none ? "" : dietarySelection.rawValue,
            intolerances: intolerancesSelection == .none ? "" : intolerancesSelection.rawValue,
            minCalories: Int(minCalories),
            maxCalories: Int(maxCalories),
            minProtein: Int(minProtein),
            maxProtein: Int(maxProtein),
            minCarbs: Int(minCarbs),
            maxCarbs: Int(maxCarbs),
            minFat: Int(minFat),
            maxFat: Int(maxFat),
            minSugar: Int(minSugar),
            maxSugar: Int(maxSugar),
            totalRecipes: Int(totalRecipes)
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedRecipes):
                    recipes = fetchedRecipes
                    showResults = true
                case .failure(let error):
                    print("Error fetching recipes: \(error)")
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.6, blue: 0.8), Color.teal.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Nutrition")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Find tasty recipes by searching the compnents that you would like to eat!")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding()
                
                List {
                    Section(header: Text("Food")) {
                        Picker("Cuisine", selection: $cuisineSelection) {
                            ForEach(cuisine.allCases) { cuisine in
                                Text(cuisine.rawValue.capitalized).tag(cuisine)
                            }
                        }
                        Picker("Meal Type", selection: $mealSelection) {
                            ForEach(type.allCases) { meal in
                                Text(meal.rawValue.capitalized).tag(meal)
                            }
                        }
                        Picker("Dietary Restrictions", selection: $dietarySelection) {
                            ForEach(diet.allCases) { diet in
                                Text(diet.rawValue.capitalized).tag(diet)
                            }
                        }
                        Picker("Intolerances", selection: $intolerancesSelection) {
                            ForEach(intolerances.allCases) { intolerance in
                                Text(intolerance.rawValue.capitalized).tag(intolerance)
                            }
                        }
                    }
                    Section(header: Text("Specifications")) {
                        VStack {
                            Text("Calories")
                            HStack {
                                Slider(value: $minCalories, in: 0...1000, step: 1)
                                Slider(value: $maxCalories, in: 0...1000, step: 1)
                            }
                            Text("Range: \(Int(minCalories)) - \(Int(maxCalories)) g")
                        }
                        VStack {
                            Text("Carbohydrates (g)")
                            HStack {
                                Slider(value: $minCarbs, in: 0...100, step: 1)
                                Slider(value: $maxCarbs, in: 0...100, step: 1)
                            }
                            Text("Range: \(Int(minCarbs)) - \(Int(maxCarbs)) g")
                        }

                        VStack {
                            Text("Protein (g)")
                            HStack {
                                Slider(value: $minProtein, in: 0...100, step: 1)
                                Slider(value: $maxProtein, in: 0...100, step: 1)
                            }
                            Text("Range: \(Int(minProtein)) - \(Int(maxProtein)) g")
                        }

                        VStack {
                            Text("Fat (g)")
                            HStack {
                                Slider(value: $minFat, in: 0...100, step: 1)
                                Slider(value: $maxFat, in: 0...100, step: 1)
                            }
                            Text("Range: \(Int(minFat)) - \(Int(maxFat)) g")
                        }

                        VStack {
                            Text("Sugar (g)")
                            HStack {
                                Slider(value: $minSugar, in: 0...100, step: 1)
                                Slider(value: $maxSugar, in: 0...100, step: 1)
                            }
                            Text("Range: \(Int(minSugar)) - \(Int(maxSugar)) g")
                        }
                        VStack {
                            Text("Total Recipes")
                            HStack {
                                Slider(value: $totalRecipes, in: 0...20, step: 1)
                            }
                            Text("Recipe Count: \(Int(totalRecipes))")
                        }
                    }
                }
                .scrollContentBackground(.hidden) // Hides the white background
                
                Button(action: fetchFilteredRecipes) {
                    Text("Find Recipes")
                }
                .disabled(isLoading)
                .padding()
            }
            .sheet(isPresented: $showResults) {
                RecipeResultsView(recipes: recipes)
            }
        }
    }
}
#Preview {
    NutritionPage()
}
