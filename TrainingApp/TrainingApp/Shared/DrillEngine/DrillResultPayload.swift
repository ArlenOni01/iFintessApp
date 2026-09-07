//
//  DrillResultPayload.swift
//  TrainingApp
//

import SwiftUI

// Codable wire format for the phone <-> Watch WatchConnectivity round trip.
// Kept separate from the setup-screen config structs (which hold SwiftUI Color
// arrays that aren't Codable) and from DrillResult (used purely on-device).
struct DrillConfigPayload: Codable {
    var drillType: String
    var reps: Int
    var minRestSeconds: Int
    var maxRestSeconds: Int
    var manualAdvance: Bool
    var stimulusDuration: Int
    var soundEnabled: Bool
    var adaptiveDifficulty: Bool
    var optionNames: [String]  // active color/direction names; unused for numberCall
    var coneCount: Int         // only meaningful for numberCall
}

struct DrillResultPayload: Codable {
    var drillType: String
    var repsCompleted: Int
    var totalReps: Int
    var elapsedSeconds: Int
    var avgReactionTimeMs: Double?
    var reactionTimes: [Double]

    init(drillType: String, result: DrillResult) {
        self.drillType = drillType
        self.repsCompleted = result.repsCompleted
        self.totalReps = result.totalReps
        self.elapsedSeconds = result.elapsedSeconds
        self.avgReactionTimeMs = result.avgReactionTimeMs
        self.reactionTimes = result.reactionTimes
    }
}

extension ColorCallConfig {
    var connectivityPayload: DrillConfigPayload {
        DrillConfigPayload(
            drillType: "colorCall",
            reps: reps,
            minRestSeconds: minRestSeconds,
            maxRestSeconds: maxRestSeconds,
            manualAdvance: manualAdvance,
            stimulusDuration: stimulusDuration,
            soundEnabled: soundEnabled,
            adaptiveDifficulty: adaptiveDifficulty,
            optionNames: activeColors.map { $0.name },
            coneCount: 0
        )
    }
}

extension NumberCallConfig {
    var connectivityPayload: DrillConfigPayload {
        DrillConfigPayload(
            drillType: "numberCall",
            reps: reps,
            minRestSeconds: minRestSeconds,
            maxRestSeconds: maxRestSeconds,
            manualAdvance: manualAdvance,
            stimulusDuration: stimulusDuration,
            soundEnabled: soundEnabled,
            adaptiveDifficulty: adaptiveDifficulty,
            optionNames: [],
            coneCount: coneCount
        )
    }
}

extension DirectionCallConfig {
    var connectivityPayload: DrillConfigPayload {
        DrillConfigPayload(
            drillType: "directionCall",
            reps: reps,
            minRestSeconds: minRestSeconds,
            maxRestSeconds: maxRestSeconds,
            manualAdvance: manualAdvance,
            stimulusDuration: stimulusDuration,
            soundEnabled: soundEnabled,
            adaptiveDifficulty: adaptiveDifficulty,
            optionNames: activeDirections.map { $0.name },
            coneCount: 0
        )
    }
}

extension DrillConfigPayload {
    var stimulusPool: [DrillStimulus] {
        switch drillType {
        case "colorCall":
            return DrillColor.available.filter { optionNames.contains($0.name) }.map { $0.asStimulus }
        case "directionCall":
            return DirectionStimulus.available.filter { optionNames.contains($0.name) }.map { $0.asStimulus }
        default:
            let count = max(1, coneCount)
            return (1...count).map { number in
                DrillStimulus(id: "number-\(number)", spokenText: "\(number)", displayText: "\(number)", displayColor: nil, symbol: nil, textColor: .white)
            }
        }
    }

    var engineConfiguration: ReactionDrillEngine.Configuration {
        ReactionDrillEngine.Configuration(
            stimulusPool: stimulusPool,
            reps: reps,
            minRestSeconds: minRestSeconds,
            maxRestSeconds: maxRestSeconds,
            manualAdvance: manualAdvance,
            stimulusDuration: stimulusDuration,
            soundEnabled: soundEnabled,
            adaptiveDifficulty: adaptiveDifficulty
        )
    }

    static func defaultPayload(drillType: String) -> DrillConfigPayload {
        switch drillType {
        case "colorCall": return ColorCallConfig().connectivityPayload
        case "directionCall": return DirectionCallConfig().connectivityPayload
        default: return NumberCallConfig().connectivityPayload
        }
    }
}
