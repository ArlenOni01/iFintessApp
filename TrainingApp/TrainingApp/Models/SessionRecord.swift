//
//  SessionRecord.swift
//  TrainingApp
//
//  Created by Arlen Oni on 6/26/26.
//

import Foundation
import SwiftData

@Model
class SessionRecord {
    var id: UUID
    var date: Date
    var drillType: String
    var repsCompleted: Int
    var totalReps: Int
    var elapsedSeconds: Int
    var avgReactionTimeMs: Double?

    init(drillType: String, repsCompleted: Int, totalReps: Int, elapsedSeconds: Int, avgReactionTimeMs: Double? = nil) {
        self.id = UUID()
        self.date = Date()
        self.drillType = drillType
        self.repsCompleted = repsCompleted
        self.totalReps = totalReps
        self.elapsedSeconds = elapsedSeconds
        self.avgReactionTimeMs = avgReactionTimeMs
    }

    var drillDisplayName: String {
        switch drillType {
        case "colorCall": return "Color Call"
        case "numberCall": return "Number Call"
        case "directionCall": return "Direction Call"
        default: return drillType
        }
    }

    var drillIcon: String {
        switch drillType {
        case "colorCall": return "circle.fill"
        case "numberCall": return "number.circle.fill"
        case "directionCall": return "arrow.up.left.and.arrow.down.right.circle.fill"
        default: return "bolt.fill"
        }
    }

    var formattedTime: String {
        let m = elapsedSeconds / 60
        let s = elapsedSeconds % 60
        return String(format: "%d:%02d", m, s)
    }

    var formattedAvgReaction: String? {
        guard let ms = avgReactionTimeMs else { return nil }
        return String(format: "%.2fs", ms / 1000)
    }
}
