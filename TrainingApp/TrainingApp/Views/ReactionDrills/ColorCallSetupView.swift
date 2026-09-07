//
//  ColorCallSetupView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 5/1/26.
//

import SwiftUI

struct ColorCallSetupView: View {
    @State private var config = ColorCallConfig()
    @State private var isDrillActive = false
    @State private var sentToWatch = false

    @ObservedObject private var watchSession = PhoneSessionCoordinator.shared

    var canStart: Bool { config.activeColors.count >= 2 }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.6, blue: 0.8), Color.teal.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {

                    // MARK: Session Settings
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Session")
                            .font(.headline)

                        HStack {
                            Text("Reps")
                            Spacer()
                            Stepper("\(config.reps)", value: $config.reps, in: 1...50)
                                .fixedSize()
                        }

                        Divider()

                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Min Rest (s)")
                                    .font(.subheadline)
                                TextField("", value: $config.minRestSeconds, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .frame(width: 80)
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Max Rest (s)")
                                    .font(.subheadline)
                                TextField("", value: $config.maxRestSeconds, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .frame(width: 80)
                            }
                            Spacer()
                        }

                        Divider()

                        Toggle("Tap to advance (manual)", isOn: $config.manualAdvance)

                        if !config.manualAdvance {
                            HStack {
                                Text("Stimulus duration (s)")
                                Spacer()
                                Stepper("\(config.stimulusDuration)", value: $config.stimulusDuration, in: 1...10)
                                    .fixedSize()
                            }
                        }

                        Divider()

                        Toggle("Sound cue on stimulus", isOn: $config.soundEnabled)

                        Divider()

                        Toggle("Adaptive Difficulty", isOn: $config.adaptiveDifficulty)
                        Text("Gets tougher when you're on point, eases up when you're not.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.white.opacity(0.88))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    // MARK: Color Selection
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Active Colors")
                                .font(.headline)
                            Text("Match the colors to the physical cones you've set up.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                            ForEach(DrillColor.available) { drillColor in
                                let isOn = config.activeColors.contains(drillColor)
                                Button(action: { toggleColor(drillColor) }) {
                                    Text(drillColor.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 14)
                                        .background(drillColor.color)
                                        .foregroundColor(drillColor.textColor)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(isOn ? Color.primary.opacity(0.8) : Color.clear, lineWidth: 3)
                                        )
                                        .opacity(isOn ? 1.0 : 0.3)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.88))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    // MARK: Start Button
                    VStack(spacing: 8) {
                        Button(action: { isDrillActive = true }) {
                            Text("Start Drill")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(canStart ? Color(red: 0.0, green: 0.1, blue: 0.7) : Color.gray)
                                .cornerRadius(14)
                        }
                        .disabled(!canStart)
                        .padding(.horizontal)

                        if !canStart {
                            Text("Select at least 2 colors to start")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        if watchSession.isWatchAppInstalled {
                            Button(action: sendToWatch) {
                                Text(sentToWatch ? "Sent to Watch" : "Send to Watch")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 0.0, green: 0.1, blue: 0.7))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(12)
                            }
                            .disabled(!canStart)
                            .padding(.horizontal)
                        }
                    }

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Color Call")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $isDrillActive) {
            ReactionDrillActiveView(
                engineConfig: ReactionDrillEngine.Configuration(
                    stimulusPool: config.activeColors.map { $0.asStimulus },
                    reps: config.reps,
                    minRestSeconds: config.minRestSeconds,
                    maxRestSeconds: config.maxRestSeconds,
                    manualAdvance: config.manualAdvance,
                    stimulusDuration: config.stimulusDuration,
                    soundEnabled: config.soundEnabled,
                    adaptiveDifficulty: config.adaptiveDifficulty
                ),
                presentation: .colorCall
            )
        }
    }

    private func sendToWatch() {
        watchSession.send(config: config.connectivityPayload)
        sentToWatch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { sentToWatch = false }
    }

    private func toggleColor(_ drillColor: DrillColor) {
        if config.activeColors.contains(drillColor) {
            config.activeColors.removeAll { $0 == drillColor }
        } else {
            config.activeColors.append(drillColor)
        }
    }
}

#Preview {
    NavigationStack {
        ColorCallSetupView()
    }
}
