//
//  NumberCallSetupView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 6/26/26.
//

import SwiftUI
import SwiftData

struct NumberCallSetupView: View {
    @State private var config = NumberCallConfig()
    @State private var isDrillActive = false

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

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Number Call")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $isDrillActive) {
            NumberCallActiveView(config: config)
        }
    }
}

// MARK: - Active View

struct NumberCallActiveView: View {
    let config: NumberCallConfig

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var phase: DrillPhase = .countdown
    @State private var countdownValue: Int = 3
    @State private var currentNumber: Int? = nil
    @State private var repsCompleted: Int = 0
    @State private var countdownTimer: AnyCancellable?
    @State private var elapsedTimer: AnyCancellable?
    @State private var pendingWork: DispatchWorkItem?
    @State private var elapsedSeconds: Int = 0
    @State private var stimulusShownAt: Date?
    @State private var reactionTimes: [Double] = []

    @StateObject private var soundPlayer = SoundPlayer()

    private var result: DrillResult {
        DrillResult(repsCompleted: repsCompleted, totalReps: config.reps, elapsedSeconds: elapsedSeconds, reactionTimes: reactionTimes)
    }

    private var isFinished: Bool {
        if case .finished = phase { return true }
        return false
    }

    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            stimulusContent
            if !isFinished { exitButton }
        }
        .onAppear { startCountdown() }
        .onDisappear { cancelAll() }
        .statusBar(hidden: true)
    }

    private var backgroundColor: Color {
        switch phase {
        case .countdown, .ready: return Color(red: 0.08, green: 0.08, blue: 0.12)
        case .active: return Color(red: 0.0, green: 0.1, blue: 0.7)
        case .finished: return Color(red: 0.0, green: 0.1, blue: 0.7)
        }
    }

    @ViewBuilder
    private var stimulusContent: some View {
        switch phase {
        case .countdown:
            VStack(spacing: 16) {
                Text("Get Ready")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.6))
                Text("\(countdownValue)")
                    .font(.system(size: 120, weight: .black))
                    .foregroundColor(.white)
            }

        case .ready:
            VStack(spacing: 20) {
                Text("\(repsCompleted) / \(config.reps)")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.4))
                Circle()
                    .fill(Color.white.opacity(0.25))
                    .frame(width: 18, height: 18)
                Text("Ready...")
                    .font(.title)
                    .foregroundColor(.white.opacity(0.55))
            }

        case .active:
            VStack(spacing: 28) {
                Text("\(repsCompleted + 1) / \(config.reps)")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.65))

                if let n = currentNumber {
                    Text("\(n)")
                        .font(.system(size: 140, weight: .black))
                        .foregroundColor(.white)
                }

                if config.manualAdvance {
                    Button(action: repCompleted) {
                        Text("Done")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 48)
                            .padding(.vertical, 18)
                            .background(Color.white.opacity(0.18))
                            .cornerRadius(16)
                    }
                    .padding(.top, 20)
                }
            }

        case .finished:
            ReactionDrillResultsView(result: result, onGoAgain: restartDrill, onDone: { dismiss() })
        }
    }

    private var exitButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: endSession) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(0.45))
                        .padding(20)
                }
            }
            Spacer()
        }
    }

    private func startCountdown() {
        phase = .countdown
        countdownValue = 3
        startElapsedTimer()
        var count = 3
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                count -= 1
                if count > 0 { countdownValue = count }
                else { countdownTimer?.cancel(); phase = .ready; scheduleNextStimulus() }
            }
    }

    private func scheduleNextStimulus() {
        let delay = Double(Int.random(in: config.minRestSeconds...config.maxRestSeconds))
        let work = DispatchWorkItem { showStimulus() }
        pendingWork = work
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: work)
    }

    private func showStimulus() {
        currentNumber = Int.random(in: 1...config.coneCount)
        phase = .active
        stimulusShownAt = Date()
        if config.soundEnabled { soundPlayer.playWhistle() }
        if !config.manualAdvance {
            let work = DispatchWorkItem {
                self.reactionTimes.append(Double(self.config.stimulusDuration) * 1000)
                self.repCompleted()
            }
            pendingWork = work
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(config.stimulusDuration), execute: work)
        }
    }

    private func repCompleted() {
        pendingWork?.cancel()
        if config.manualAdvance, let shownAt = stimulusShownAt {
            reactionTimes.append(Date().timeIntervalSince(shownAt) * 1000)
        }
        stimulusShownAt = nil
        repsCompleted += 1
        if repsCompleted >= config.reps { finishSession() }
        else { phase = .ready; scheduleNextStimulus() }
    }

    private func finishSession() {
        cancelAll()
        saveSession()
        phase = .finished
    }

    private func endSession() {
        cancelAll()
        saveSession()
        phase = .finished
    }

    private func saveSession() {
        let record = SessionRecord(
            drillType: "numberCall",
            repsCompleted: repsCompleted,
            totalReps: config.reps,
            elapsedSeconds: elapsedSeconds,
            avgReactionTimeMs: result.avgReactionTimeMs
        )
        modelContext.insert(record)
    }

    private func restartDrill() {
        cancelAll()
        repsCompleted = 0
        currentNumber = nil
        elapsedSeconds = 0
        reactionTimes = []
        stimulusShownAt = nil
        startCountdown()
    }

    private func startElapsedTimer() {
        elapsedTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in elapsedSeconds += 1 }
    }

    private func cancelAll() {
        countdownTimer?.cancel()
        elapsedTimer?.cancel()
        pendingWork?.cancel()
    }
}

#Preview {
    NavigationStack { NumberCallSetupView() }
}
