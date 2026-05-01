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
                    }

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Color Call")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $isDrillActive) {
            ReactionDrillActiveView(config: config)
        }
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
