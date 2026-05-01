//
//  DrillsPage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI

struct WorkoutRow: View {
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
}

struct DrillsPage: View {
    private let categories: [(category: FullWorkList, workouts: [SpecificList])] = [
        (ImageList.drillImages[0], DrillList.coneDrillWork),
        (ImageList.drillImages[1], DrillList.coreStrengthWork),
        (ImageList.drillImages[2], DrillList.explosivenessWork),
        (ImageList.drillImages[3], DrillList.ladderWork),
        (ImageList.drillImages[4], DrillList.lowerBodyWork),
        (ImageList.drillImages[5], DrillList.upperBodyWork)
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
                Text("Train")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                NavigationStack {
                    List {

                        // MARK: Tools
                        Section {
                            NavigationLink(destination: TimerPage()) {
                                ToolRow(
                                    icon: "timer",
                                    color: .blue,
                                    title: "Interval Timer",
                                    subtitle: "Configure reps, set time, and rest intervals"
                                )
                            }
                        }

                        // MARK: Reaction Drills
                        Section(header: Text("Reaction Drills")) {
                            NavigationLink(destination: ColorCallSetupView()) {
                                ToolRow(
                                    icon: "circle.fill",
                                    color: .purple,
                                    title: "Color Call",
                                    subtitle: "React to colored cone signals"
                                )
                            }
                        }

                        // MARK: Drill Categories
                        Section(header: Text("Drill Library")) {
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
                                gradient: Gradient(colors: [Color(red: 0.3, green: 0.6, blue: 0.8), Color.teal.opacity(0.2)]),
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

// Shared row for non-workout navigation items (Timer, Reaction Drills)
private struct ToolRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.12))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    DrillsPage()
}
