//
//  APIRequests.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/27/24.
//

import Foundation

struct RecipeResponse: Codable {
    let results: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    //let imageURL: String
    let calories: Int?
    let protein: String?
    let fat: String?
    let carbs: String?
    let sugar: String?
}

class SpoonacularService: ObservableObject {
    private let apiKey = "6361dd2405fc41d189b496a07f79b97a"
    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    func fetchRecipes(
        type: String,
        cuisine: String,
        diet: String,
        intolerances: String,
        minCalories: Int,
        maxCalories: Int,
        minProtein: Int,
        maxProtein: Int,
        minCarbs: Int,
        maxCarbs: Int,
        minFat: Int,
        maxFat: Int,
        minSugar: Int,
        maxSugar: Int,
        totalRecipes: Int,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "cuisine", value: cuisine),
            URLQueryItem(name: "diet", value: diet),
            URLQueryItem(name: "intolerances", value: intolerances),
            URLQueryItem(name: "minCalories", value: String(minCalories)),
            URLQueryItem(name: "maxCalories", value: String(maxCalories)),
            URLQueryItem(name: "minProtein", value: String(minProtein)),
            URLQueryItem(name: "maxProtein", value: String(maxProtein)),
            URLQueryItem(name: "minCarbs", value: String(minCarbs)),
            URLQueryItem(name: "maxCarbs", value: String(maxCarbs)),
            URLQueryItem(name: "minFat", value: String(minFat)),
            URLQueryItem(name: "maxFat", value: String(maxFat)),
            URLQueryItem(name: "minSugar", value: String(minSugar)),
            URLQueryItem(name: "maxSugar", value: String(maxSugar)),
            URLQueryItem(name: "number", value: String(totalRecipes)) // Adjust for the number of recipes you want
        ]
        
        guard let url = urlComponents.url else {
                print("Failed to create URL.")
                return
            }
            print("Request URL: \(url)")

            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                    if !(200...299).contains(httpResponse.statusCode) {
                        print("Server returned an error: \(httpResponse.statusCode)")
                        completion(.failure(NSError(domain: "Server error", code: httpResponse.statusCode, userInfo: nil)))
                        return
                    }
                }
                
                guard let data = data else {
                    print("No data received.")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(RecipeResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    print("Decoding Error: \(error)")
                    print("Response Data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string.")")
                    completion(.failure(error))
                }
            }.resume()
        }
}
