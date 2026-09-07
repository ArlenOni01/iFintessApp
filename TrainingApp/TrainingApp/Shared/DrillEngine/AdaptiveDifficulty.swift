//
//  AdaptiveDifficulty.swift
//  TrainingApp
//

import Foundation

// Within-session difficulty that rubber-bands to the athlete's own pace: tightens
// the rest window (and stimulus duration, in auto-advance mode) after a clean, fast
// rep, eases back off after a slow one. Self-relative to a rolling EMA of this
// session's reaction times, so it needs no fixed benchmark table.
struct AdaptiveDifficultyState {
    private(set) var minRest: Double
    private(set) var maxRest: Double
    private(set) var stimulusDuration: Double

    private let originalMinRest: Double
    private let originalMaxRest: Double
    private let originalStimulusDuration: Double
    private var emaReactionMs: Double?

    private let restFloor: Double = 1.0
    private let restStep: Double = 0.3
    private let stimulusFloor: Double = 0.6
    private let stimulusStep: Double = 0.2
    private let easeCeilingMultiplier: Double = 1.5

    init(minRest: Double, maxRest: Double, stimulusDuration: Double) {
        self.minRest = minRest
        self.maxRest = maxRest
        self.stimulusDuration = stimulusDuration
        self.originalMinRest = minRest
        self.originalMaxRest = maxRest
        self.originalStimulusDuration = stimulusDuration
    }

    mutating func recordReaction(_ reactionMs: Double) {
        guard let ema = emaReactionMs else {
            emaReactionMs = reactionMs
            return
        }

        if reactionMs < ema * 0.9 {
            tighten()
        } else if reactionMs > ema * 1.15 {
            ease()
        }

        emaReactionMs = ema * 0.7 + reactionMs * 0.3
    }

    private mutating func tighten() {
        minRest = max(restFloor, minRest - restStep)
        maxRest = max(minRest + 0.5, maxRest - restStep)
        stimulusDuration = max(stimulusFloor, stimulusDuration - stimulusStep)
    }

    private mutating func ease() {
        minRest = min(originalMinRest * easeCeilingMultiplier, minRest + restStep)
        maxRest = min(originalMaxRest * easeCeilingMultiplier, maxRest + restStep)
        stimulusDuration = min(originalStimulusDuration, stimulusDuration + stimulusStep)
    }
}
