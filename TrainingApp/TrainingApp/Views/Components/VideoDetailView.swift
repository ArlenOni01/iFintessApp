//
//  VideoDetailView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/18/23.
//

import SwiftUI

struct VideoDetailView: View {
    
    var image: SpecificList

    var body: some View {
        Group {
            if image.vidName2 != nil {
                // Two stacked photos can run taller than the screen, so this
                // case scrolls, reading top to bottom.
                ScrollView {
                    detailContent
                        .padding(.vertical)
                }
            } else {
                // A single animation or photo is usually shorter than the
                // screen — center it instead of leaving it pinned to the top
                // with empty space below.
                detailContent
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }

    @ViewBuilder
    private var detailContent: some View {
        VStack {
            Text(image.workoutName)
                .font(.title)
                .fontWeight(.bold)
                .cornerRadius(12)
                .padding(.horizontal)

            if let pattern = image.footworkPattern {
                FootworkAnimationView(pattern: pattern)
                    .frame(height: 260)
                    .padding(.horizontal)
            } else if let ladderPattern = image.ladderPattern {
                LadderAnimationView(pattern: ladderPattern)
                    .frame(height: 340)
                    .padding(.horizontal)
            } else if let vidName2 = image.vidName2 {
                VStack(spacing: 16) {
                    LabeledExercisePhoto(vidName: image.vidName, label: "Start")
                    LabeledExercisePhoto(vidName: vidName2, label: "Finish")
                }
                .padding(.horizontal)
            } else {
                Image(image.vidName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }

            Text(image.wkDescription)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}
private struct LabeledExercisePhoto: View {
    let vidName: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Image(vidName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(12)

            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    VideoDetailView(image: WorkoutList.ankleWork.first!)
}
