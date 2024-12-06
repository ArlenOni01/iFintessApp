//
//  DrillsPage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/13/24.
//

import SwiftUI

/*struct WorkoutRow: View {
    var imageName: String
    var workoutName: String
    var wkDescription: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(6)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(workoutName)
                    .fontWeight(.semibold)
                
                Text(wkDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}*/

struct ExercisesPage: View {
    var drillImage: [FullWorkList] = ImageList.drillImages
    
    var coneDrills: [SpecificList] = DrillList.coneDrillWork
    
    var coreStrength: [SpecificList] = DrillList.coreStrengthWork
    
    var explosiveness: [SpecificList] = DrillList.explosivenessWork
    
    var ladder: [SpecificList] = DrillList.ladderWork
    
    var lowerBody: [SpecificList] = DrillList.lowerBodyWork
    
    var upperBody: [SpecificList] = DrillList.upperBodyWork
    
    @State var isSelected: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Drill Workouts")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                }
                
                NavigationStack {
                    List {
                        ForEach(drillImage) { image in
                            NavigationLink(value: image) {
                                WorkoutRow(imageName: image.imageName, workoutName: image.title, wkDescription: image.description)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: FullWorkList.self) { image in
                        // Content for each drill category
                        List {
                            if image.title == "Cone Drills" {
                                ForEach(coneDrills) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Core Strength" {
                                ForEach(coreStrength) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            }else if image.title == "Explosiveness" {
                                ForEach(explosiveness) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Ladder Drills" {
                                ForEach(ladder) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Lower Body" {
                                ForEach(lowerBody) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Upper Body" {
                                ForEach(upperBody) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            }
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 0.3, green: 0.6, blue: 0.8), Color.teal.opacity(0.2)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .padding()
        }
    }
}
#Preview {
    ExercisesPage()
}
