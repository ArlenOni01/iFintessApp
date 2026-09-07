//
//  WatchDrillView.swift
//  TrainingApp Watch App Watch App
//

import SwiftUI
import WatchKit
import AVFoundation

// Runs a drill entirely on the wrist: haptic + spoken cue on each stimulus, any
// tap registers the reaction. No phone screen involved. Driven by the same
// ReactionDrillEngine the iOS app uses, so behavior (including adaptive
// difficulty) matches exactly.
struct WatchDrillView: View {
    let engineConfig: ReactionDrillEngine.Configuration
    let drillType: String

    @Environment(\.dismiss) private var dismiss
    @StateObject private var engine: ReactionDrillEngine
    private let speechSynthesizer = AVSpeechSynthesizer()

    init(engineConfig: ReactionDrillEngine.Configuration, drillType: String) {
        self.engineConfig = engineConfig
        self.drillType = drillType
        _engine = StateObject(wrappedValue: ReactionDrillEngine(config: engineConfig))
    }

    private var backgroundColor: Color {
        switch engine.phase {
        case .active:
            return engine.currentStimulus?.displayColor ?? .blue
        case .finished:
            return .blue
        case .countdown, .ready:
            return .black
        }
    }

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            content
        }
        .onAppear {
            engine.onStimulusShown = { stimulus in
                WKInterfaceDevice.current().play(.notification)
                if engineConfig.soundEnabled {
                    speak(stimulus.spokenText)
                }
            }
            engine.onFinished = { result in
                WatchSessionCoordinator.shared.send(result: DrillResultPayload(drillType: drillType, result: result))
            }
            engine.start()
        }
        .onDisappear { engine.teardown() }
        .onTapGesture { engine.registerReaction() }
    }

    @ViewBuilder
    private var content: some View {
        switch engine.phase {
        case .countdown:
            Text("\(engine.countdownValue)")
                .font(.system(size: 54, weight: .black))
                .foregroundColor(.white)

        case .ready:
            VStack(spacing: 6) {
                Text("\(engine.repsCompleted)/\(engineConfig.reps)")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.5))
                Text("Ready...")
                    .foregroundColor(.white.opacity(0.6))
            }

        case .active:
            VStack(spacing: 6) {
                Text("\(engine.repsCompleted + 1)/\(engineConfig.reps)")
                    .font(.caption2)
                    .foregroundColor((engine.currentStimulus?.textColor ?? .white).opacity(0.7))

                if let symbol = engine.currentStimulus?.symbol {
                    Image(systemName: symbol)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(engine.currentStimulus?.textColor ?? .white)
                }

                Text(engine.currentStimulus?.displayText ?? "")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(engine.currentStimulus?.textColor ?? .white)

                if engineConfig.manualAdvance {
                    Text("Tap to react")
                        .font(.caption2)
                        .foregroundColor((engine.currentStimulus?.textColor ?? .white).opacity(0.6))
                }
            }

        case .finished:
            VStack(spacing: 8) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(engine.result.repsCompleted)/\(engine.result.totalReps) reps")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                if let avg = engine.result.formattedAvgReaction {
                    Text("Avg \(avg)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                }
                Button("Close") { dismiss() }
                    .font(.caption)
                    .padding(.top, 4)
            }
        }
    }

    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.52
        speechSynthesizer.speak(utterance)
    }
}
