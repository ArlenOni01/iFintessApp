//
//  ReactionDrillActiveView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 5/1/26.
//

import SwiftUI
import Combine

// Phases the drill moves through in order
enum DrillPhase {
    case countdown  // 3-2-1 before the first rep
    case ready      // neutral pause between reps
    case active     // stimulus is showing
    case finished   // all reps done
}

struct ReactionDrillActiveView: View {
    let config: ColorCallConfig

    @Environment(\.dismiss) private var dismiss

    // Drill state
    @State private var phase: DrillPhase = .countdown
    @State private var countdownValue: Int = 3
    @State private var currentColor: DrillColor? = nil
    @State private var repsCompleted: Int = 0

    // Timing
    @State private var countdownTimer: AnyCancellable?
    @State private var elapsedTimer: AnyCancellable?
    @State private var pendingWork: DispatchWorkItem?
    @State private var elapsedSeconds: Int = 0

    @StateObject private var soundPlayer = SoundPlayer()

    // MARK: - Computed helpers

    private var backgroundColor: Color {
        switch phase {
        case .countdown, .ready:
            return Color(red: 0.08, green: 0.08, blue: 0.12)
        case .active:
            return currentColor?.color ?? .black
        case .finished:
            return Color(red: 0.0, green: 0.1, blue: 0.7)
        }
    }

    private var result: DrillResult {
        DrillResult(repsCompleted: repsCompleted, totalReps: config.reps, elapsedSeconds: elapsedSeconds)
    }

    private var isFinished: Bool {
        if case .finished = phase { return true }
        return false
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            stimulusContent

            if !isFinished {
                exitButton
            }
        }
        .onAppear { startCountdown() }
        .onDisappear { cancelAll() }
        .statusBar(hidden: true)
    }

    // MARK: - Phase views

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
                    .foregroundColor((currentColor?.textColor ?? .white).opacity(0.65))

                Text(currentColor?.name.uppercased() ?? "")
                    .font(.system(size: 88, weight: .black))
                    .foregroundColor(currentColor?.textColor ?? .white)

                if config.manualAdvance {
                    Button(action: repCompleted) {
                        Text("Done")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(currentColor?.textColor ?? .white)
                            .padding(.horizontal, 48)
                            .padding(.vertical, 18)
                            .background((currentColor?.textColor ?? .white).opacity(0.18))
                            .cornerRadius(16)
                    }
                    .padding(.top, 20)
                }
            }

        case .finished:
            ReactionDrillResultsView(
                result: result,
                onGoAgain: restartDrill,
                onDone: { dismiss() }
            )
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

    // MARK: - Timing engine

    private func startCountdown() {
        phase = .countdown
        countdownValue = 3
        startElapsedTimer()

        var count = 3
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                count -= 1
                if count > 0 {
                    countdownValue = count
                } else {
                    countdownTimer?.cancel()
                    phase = .ready
                    scheduleNextStimulus()
                }
            }
    }

    private func scheduleNextStimulus() {
        let delay = Double(Int.random(in: config.minRestSeconds...config.maxRestSeconds))
        let work = DispatchWorkItem { showStimulus() }
        pendingWork = work
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: work)
    }

    private func showStimulus() {
        guard let color = config.activeColors.randomElement() else { return }
        currentColor = color
        phase = .active
        if config.soundEnabled { soundPlayer.playWhistle() }

        if !config.manualAdvance {
            let work = DispatchWorkItem { repCompleted() }
            pendingWork = work
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Double(config.stimulusDuration),
                execute: work
            )
        }
    }

    private func repCompleted() {
        pendingWork?.cancel()
        repsCompleted += 1
        if repsCompleted >= config.reps {
            finishSession()
        } else {
            phase = .ready
            scheduleNextStimulus()
        }
    }

    private func finishSession() {
        cancelAll()
        phase = .finished
    }

    private func endSession() {
        cancelAll()
        phase = .finished
    }

    private func restartDrill() {
        cancelAll()
        repsCompleted = 0
        currentColor = nil
        elapsedSeconds = 0
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
    ReactionDrillActiveView(config: ColorCallConfig())
}
