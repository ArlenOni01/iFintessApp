//
//  MobilityPage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI

struct MobilityPage: View {
    var mobilityImage: [FullWorkList] = ImageList.mobilityImages
    
    var ankleWork: [SpecificList] = WorkoutList.ankleWork
    
    var hipWork: [SpecificList] = WorkoutList.hipWork
    
    var kneeWork: [SpecificList] = WorkoutList.kneeWork
    
    var lowerLegWork: [SpecificList] = WorkoutList.lowerLegWork
    
    var shoulderWork: [SpecificList] = WorkoutList.shoulderWork
    
    var wristWork: [SpecificList] = WorkoutList.wristWork
    
    var yogaWork: [SpecificList] = WorkoutList.yogaWork
    
    var calisthenicWork: [SpecificList] = WorkoutList.calisthenicWork
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Mobility")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                }
                
                NavigationStack {
                    List {
                        ForEach(mobilityImage) { image in
                            NavigationLink(value: image) {
                                WorkoutRow(imageName: image.imageName, workoutName: image.title, wkDescription: image.description)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: FullWorkList.self) { image in
                        List {
                            if image.title == "Ankle" {
                                ForEach(ankleWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Hip" {
                                ForEach(hipWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Calisthenics" {
                                ForEach(calisthenicWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Knee" {
                                ForEach(kneeWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Lower Leg" {
                                ForEach(lowerLegWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Shoulder" {
                                ForEach(shoulderWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Wrist" {
                                ForEach(wristWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            } else if image.title == "Yoga" {
                                ForEach(yogaWork) { workout in
                                    NavigationLink(destination: VideoDetailView(image: workout)) {
                                        WorkoutRow(imageName: image.imageName, workoutName: workout.workoutName, wkDescription: workout.wkDescription)
                                    }
                                }
                            }
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
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
    MobilityPage()
}
