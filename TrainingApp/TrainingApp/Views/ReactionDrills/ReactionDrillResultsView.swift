//
//  ReactionDrillResultsView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 5/1/26.
//

import SwiftUI

struct ReactionDrillResultsView: View {
    let result: DrillResult
    let onGoAgain: () -> Void
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 12) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.white.opacity(0.85))

                Text("Session Complete")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }

            Spacer()

            HStack(spacing: 16) {
                StatCard(label: "Reps", value: "\(result.repsCompleted) / \(result.totalReps)")
                StatCard(label: "Time", value: result.formattedTime)
            }
            .padding(.horizontal)

            Spacer()

            VStack(spacing: 14) {
                Button(action: onGoAgain) {
                    Text("Go Again")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.0, green: 0.1, blue: 0.7))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                        .padding(.horizontal)
                }

                Button(action: onDone) {
                    Text("Done")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(14)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 50)
        }
    }
}

private struct StatCard: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 10) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.65))
            Text(value)
                .font(.system(size: 44, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color(red: 0.0, green: 0.1, blue: 0.7).edgesIgnoringSafeArea(.all)
        ReactionDrillResultsView(
            result: DrillResult(repsCompleted: 10, totalReps: 10, elapsedSeconds: 97),
            onGoAgain: {},
            onDone: {}
        )
    }
}
