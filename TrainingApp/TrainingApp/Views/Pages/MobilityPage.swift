//
//  MobilityPage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI

struct MobilityPage: View {
    private let categories: [(category: FullWorkList, workouts: [SpecificList])] = [
        (ImageList.mobilityImages[0], WorkoutList.ankleWork),
        (ImageList.mobilityImages[1], WorkoutList.calisthenicWork),
        (ImageList.mobilityImages[2], WorkoutList.hipWork),
        (ImageList.mobilityImages[3], WorkoutList.kneeWork),
        (ImageList.mobilityImages[4], WorkoutList.lowerLegWork),
        (ImageList.mobilityImages[5], WorkoutList.shoulderWork),
        (ImageList.mobilityImages[6], WorkoutList.wristWork),
        (ImageList.mobilityImages[7], WorkoutList.yogaWork)
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Mobility")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                NavigationStack {
                    List {
                        ForEach(categories, id: \.category.id) { entry in
                            NavigationLink(value: entry.category) {
                                WorkoutRow(
                                    imageName: entry.category.imageName,
                                    workoutName: entry.category.title,
                                    wkDescription: entry.category.description
                                )
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: FullWorkList.self) { category in
                        let workouts = categories.first { $0.category.id == category.id }?.workouts ?? []
                        List(workouts) { workout in
                            NavigationLink(destination: VideoDetailView(image: workout)) {
                                WorkoutRow(
                                    imageName: category.imageName,
                                    workoutName: workout.workoutName,
                                    wkDescription: workout.wkDescription
                                )
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
                        .navigationTitle(category.title)
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
