//
//  ReactionDrillActiveView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 5/1/26.
//

import SwiftUI
import SwiftData

// Describes how a drill type should look, driven by ReactionDrillEngine's shared
// phase/stimulus state. Color Call fills the screen with the stimulus's own color;
// Number/Direction Call use a fixed background and show text/symbol instead.
struct DrillPresentation {
    let drillType: String
    let activeBackground: Color
    let useStimulusColorForBackground: Bool
    let showSymbol: Bool
    let activeTextSize: CGFloat

    static let colorCall = DrillPresentation(
        drillType: "colorCall",
        activeBackground: .black,
        useStimulusColorForBackground: true,
        showSymbol: false,
        activeTextSize: 88
    )

    static let numberCall = DrillPresentation(
        drillType: "numberCall",
        activeBackground: Color(red: 0.0, green: 0.1, blue: 0.7),
        useStimulusColorForBackground: false,
        showSymbol: false,
        activeTextSize: 140
    )

    static let directionCall = DrillPresentation(
        drillType: "directionCall",
        activeBackground: Color(red: 0.05, green: 0.25, blue: 0.55),
        useStimulusColorForBackground: false,
        showSymbol: true,
        activeTextSize: 44
    )
}

struct ReactionDrillActiveView: View {
    let engineConfig: ReactionDrillEngine.Configuration
    let presentation: DrillPresentation

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @StateObject private var engine: ReactionDrillEngine
    @StateObject private var soundPlayer = SoundPlayer()

    init(engineConfig: ReactionDrillEngine.Configuration, presentation: DrillPresentation) {
        self.engineConfig = engineConfig
        self.presentation = presentation
        _engine = StateObject(wrappedValue: ReactionDrillEngine(config: engineConfig))
    }

    // MARK: - Computed helpers

    private var backgroundColor: Color {
        switch engine.phase {
        case .countdown, .ready:
            return Color(red: 0.08, green: 0.08, blue: 0.12)
        case .active:
            if presentation.useStimulusColorForBackground {
                return engine.currentStimulus?.displayColor ?? .black
            }
            return presentation.activeBackground
        case .finished:
            return Color(red: 0.0, green: 0.1, blue: 0.7)
        }
    }

    private var activeTextColor: Color {
        presentation.useStimulusColorForBackground ? (engine.currentStimulus?.textColor ?? .white) : .white
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            stimulusContent

            if !engine.isFinished {
                exitButton
            }
        }
        .onAppear {
            engine.onStimulusShown = { _ in
                if engineConfig.soundEnabled {
                    soundPlayer.playWhistle()
                }
            }
            engine.onFinished = { result in
                saveSession(result: result)
            }
            engine.start()
        }
        .onDisappear { engine.teardown() }
        .statusBar(hidden: true)
    }

    // MARK: - Phase views

    @ViewBuilder
    private var stimulusContent: some View {
        switch engine.phase {

        case .countdown:
            VStack(spacing: 16) {
                Text("Get Ready")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.6))
                Text("\(engine.countdownValue)")
                    .font(.system(size: 120, weight: .black))
                    .foregroundColor(.white)
            }

        case .ready:
            VStack(spacing: 20) {
                Text("\(engine.repsCompleted) / \(engineConfig.reps)")
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
                Text("\(engine.repsCompleted + 1) / \(engineConfig.reps)")
                    .font(.title3)
                    .foregroundColor(activeTextColor.opacity(0.65))

                if presentation.showSymbol, let symbol = engine.currentStimulus?.symbol {
                    Image(systemName: symbol)
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(activeTextColor)
                }

                Text(engine.currentStimulus?.displayText ?? "")
                    .font(.system(size: presentation.activeTextSize, weight: .black))
                    .foregroundColor(activeTextColor)

                if engineConfig.manualAdvance {
                    Button(action: { engine.registerReaction() }) {
                        Text("Done")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(activeTextColor)
                            .padding(.horizontal, 48)
                            .padding(.vertical, 18)
                            .background(activeTextColor.opacity(0.18))
                            .cornerRadius(16)
                    }
                    .padding(.top, 20)
                }
            }

        case .finished:
            ReactionDrillResultsView(
                result: engine.result,
                onGoAgain: { engine.restart() },
                onDone: { dismiss() }
            )
        }
    }

    private var exitButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { engine.endSession() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(0.45))
                        .padding(20)
                }
            }
            Spacer()
        }
    }

    // MARK: - Persistence

    private func saveSession(result: DrillResult) {
        let record = SessionRecord(
            drillType: presentation.drillType,
            repsCompleted: result.repsCompleted,
            totalReps: result.totalReps,
            elapsedSeconds: result.elapsedSeconds,
            avgReactionTimeMs: result.avgReactionTimeMs
        )
        modelContext.insert(record)
    }
}

#Preview {
    ReactionDrillActiveView(
        engineConfig: ReactionDrillEngine.Configuration(
            stimulusPool: DrillColor.available.map { $0.asStimulus },
            reps: 10,
            minRestSeconds: 2,
            maxRestSeconds: 5,
            manualAdvance: true,
            stimulusDuration: 3,
            soundEnabled: true,
            adaptiveDifficulty: true
        ),
        presentation: .colorCall
    )
}
