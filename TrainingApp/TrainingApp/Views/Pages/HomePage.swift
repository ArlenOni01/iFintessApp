//
//  HomePage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI
import PhotosUI

struct HomePage: View {
    
    @State private var quotes: [AnimeQuote] = loadQuotesFromCSV()
    @State private var currentQuote: AnimeQuote? = nil
    @State private var selectedImages: [UIImage] = []
    @State private var showPicker = false
    @State private var showingImagePicker = false      // Controls image picker display
    
    let rows = Array(repeating: GridItem(.fixed(100)), count: 3)
    
    var body: some View {
        ZStack {
            // Background gradient for a calm, wellness feel
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.0, green: 0.1, blue: 0.7), Color.teal.opacity(0.3)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Logo at the top with aesthetic styling
                Image("HomeLogo-noBackground")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 10) // Soft shadow for aesthetics
                    .padding(.top, 60) // Spacing from top
                
                TabView {
                    VStack {
                        // Add some welcoming text or other elements below the logo
                        Text("Welcome to Phesian!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.top, 20)
                        VStack{
                            Text("Quote of the day:")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .padding(.top, 20)
                            
                            Text(currentQuote?.quote ?? "Push the button to get a new quote.")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .padding(.top, 10)
                            //.animation(.easeInOut, value: currentQuote)
                            
                            Button(action: {
                                if !quotes.isEmpty {
                                    currentQuote = quotes.randomElement()
                                }
                            }) {
                                Text("New Quote")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                    .padding(.bottom)
                            }
                        }
                        .background(Color.white.opacity(0.4)) // Semi-transparent background
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // Apply rounded clipping
                        .shadow(radius: 10) // Optional: Add a shadow for depth
                        .padding()
                        Spacer()
                        
                        // Add text for swiping feature to see how to create vision board
                    }
                    .padding(.bottom)
                    //insert the tab item icon here
                    
                    
                    //Secondary View
                    VStack {
                        // Button to open the image picker
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Text("Select Photos")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .sheet(isPresented: $showingImagePicker) {
                            PhotoPickerView(selectedImages: $selectedImages)
                        }
                        
                        // Display selected images in a grid or any layout
                        if !selectedImages.isEmpty {
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))]) {
                                    ForEach(selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 180, height: 180)  // Increase image size slightly
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                            }
                        } else {
                            Text("No photos selected")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    //insert the tab item icon here
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .edgesIgnoringSafeArea(.all)
        }
    }
}
#Preview {
    HomePage()
}
