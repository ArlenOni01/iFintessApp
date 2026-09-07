//
//  NumberCallSetupView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 6/26/26.
//

import SwiftUI

struct NumberCallSetupView: View {
    @State private var config = NumberCallConfig()
    @State private var isDrillActive = false
    @State private var sentToWatch = false

    @ObservedObject private var watchSession = PhoneSessionCoordinator.shared

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

                    // MARK: Cone Count
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Number of Cones")
                                .font(.headline)
                            Text("Set out this many numbered cones on the field.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Text("Cones")
                            Spacer()
                            Stepper("\(config.coneCount)", value: $config.coneCount, in: 2...8)
                                .fixedSize()
                        }

                        // Cone badge preview
                        HStack(spacing: 8) {
                            ForEach(1...config.coneCount, id: \.self) { n in
                                Text("\(n)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: 40, height: 40)
                                    .background(Color(red: 0.0, green: 0.1, blue: 0.7))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.88))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    // MARK: Start Button
                    Button(action: { isDrillActive = true }) {
                        Text("Start Drill")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.0, green: 0.1, blue: 0.7))
                            .cornerRadius(14)
                    }
                    .padding(.horizontal)

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
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Number Call")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $isDrillActive) {
            ReactionDrillActiveView(
                engineConfig: ReactionDrillEngine.Configuration(
                    stimulusPool: config.stimulusPool,
                    reps: config.reps,
                    minRestSeconds: config.minRestSeconds,
                    maxRestSeconds: config.maxRestSeconds,
                    manualAdvance: config.manualAdvance,
                    stimulusDuration: config.stimulusDuration,
                    soundEnabled: config.soundEnabled,
                    adaptiveDifficulty: config.adaptiveDifficulty
                ),
                presentation: .numberCall
            )
        }
    }

    private func sendToWatch() {
        watchSession.send(config: config.connectivityPayload)
        sentToWatch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { sentToWatch = false }
    }
}

#Preview {
    NavigationStack { NumberCallSetupView() }
}
