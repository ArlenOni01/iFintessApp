//
//  ReactionDrillEngine.swift
//  TrainingApp
//

import Combine
import Foundation

// Phases any reaction drill moves through, in order.
enum DrillPhase {
    case countdown  // 3-2-1 before the first rep
    case ready      // neutral pause between reps
    case active     // stimulus is showing
    case finished   // all reps done
}

// Shared timing engine for Color/Number/Direction Call. Platform-agnostic (no
// UIKit/WatchKit/AVFoundation) so both the iOS active view and the Watch app can
// drive their own presentation (color fill + whistle vs. haptic + speech) off it.
@MainActor
final class ReactionDrillEngine: ObservableObject {
    struct Configuration {
        var stimulusPool: [DrillStimulus]
        var reps: Int
        var minRestSeconds: Int
        var maxRestSeconds: Int
        var manualAdvance: Bool
        var stimulusDuration: Int
        var soundEnabled: Bool
        var adaptiveDifficulty: Bool
    }

    @Published private(set) var phase: DrillPhase = .countdown
    @Published private(set) var countdownValue: Int = 3
    @Published private(set) var currentStimulus: DrillStimulus?
    @Published private(set) var repsCompleted: Int = 0
    @Published private(set) var elapsedSeconds: Int = 0

    let config: Configuration

    // Fired each time a stimulus is presented, so the view layer can play a
    // sound (iOS) or speak + haptic (Watch) without the engine knowing either.
    var onStimulusShown: ((DrillStimulus) -> Void)?
    // Fired exactly once when the session ends, so the view layer can persist it.
    var onFinished: ((DrillResult) -> Void)?

    private var countdownTimer: AnyCancellable?
    private var elapsedTimer: AnyCancellable?
    private var pendingWork: DispatchWorkItem?
    private var stimulusShownAt: Date?
    private var reactionTimes: [Double] = []
    private var difficulty: AdaptiveDifficultyState

    init(config: Configuration) {
        self.config = config
        self.difficulty = AdaptiveDifficultyState(
            minRest: Double(config.minRestSeconds),
            maxRest: Double(config.maxRestSeconds),
            stimulusDuration: Double(config.stimulusDuration)
        )
    }

    var result: DrillResult {
        DrillResult(repsCompleted: repsCompleted, totalReps: config.reps, elapsedSeconds: elapsedSeconds, reactionTimes: reactionTimes)
    }

    var isFinished: Bool {
        if case .finished = phase { return true }
        return false
    }

    func start() {
        phase = .countdown
        countdownValue = 3
        startElapsedTimer()

        var count = 3
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                count -= 1
                if count > 0 {
                    self.countdownValue = count
                } else {
                    self.countdownTimer?.cancel()
                    self.phase = .ready
                    self.scheduleNextStimulus()
                }
            }
    }

    // Call when the athlete reacts (tap on iOS, tap/crown on Watch).
    func registerReaction() {
        guard phase == .active, config.manualAdvance, let shownAt = stimulusShownAt else { return }
        completeRep(reactionMs: Date().timeIntervalSince(shownAt) * 1000)
    }

    func endSession() {
        cancelTimers()
        phase = .finished
        onFinished?(result)
    }

    func restart() {
        cancelTimers()
        repsCompleted = 0
        currentStimulus = nil
        elapsedSeconds = 0
        reactionTimes = []
        stimulusShownAt = nil
        difficulty = AdaptiveDifficultyState(
            minRest: Double(config.minRestSeconds),
            maxRest: Double(config.maxRestSeconds),
            stimulusDuration: Double(config.stimulusDuration)
        )
        start()
    }

    func teardown() {
        cancelTimers()
    }

    private func scheduleNextStimulus() {
        let minRest = config.adaptiveDifficulty ? difficulty.minRest : Double(config.minRestSeconds)
        let maxRest = config.adaptiveDifficulty ? difficulty.maxRest : Double(config.maxRestSeconds)
        let delay = Double.random(in: minRest...max(minRest, maxRest))
        let work = DispatchWorkItem { [weak self] in self?.showStimulus() }
        pendingWork = work
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: work)
    }

    private func showStimulus() {
        guard let stimulus = config.stimulusPool.randomElement() else { return }
        currentStimulus = stimulus
        phase = .active
        stimulusShownAt = Date()
        onStimulusShown?(stimulus)

        if !config.manualAdvance {
            let duration = config.adaptiveDifficulty ? difficulty.stimulusDuration : Double(config.stimulusDuration)
            let work = DispatchWorkItem { [weak self] in self?.completeRep(reactionMs: duration * 1000) }
            pendingWork = work
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: work)
        }
    }

    private func completeRep(reactionMs: Double) {
        pendingWork?.cancel()
        reactionTimes.append(reactionMs)
        stimulusShownAt = nil
        repsCompleted += 1

        if config.adaptiveDifficulty {
            difficulty.recordReaction(reactionMs)
        }

        if repsCompleted >= config.reps {
            cancelTimers()
            phase = .finished
            onFinished?(result)
        } else {
            phase = .ready
            scheduleNextStimulus()
        }
    }

    private func startElapsedTimer() {
        elapsedTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.elapsedSeconds += 1 }
    }

    private func cancelTimers() {
        countdownTimer?.cancel()
        elapsedTimer?.cancel()
        pendingWork?.cancel()
    }
}
