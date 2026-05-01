//
//  ReactionDrillModels.swift
//  TrainingApp
//
//  Created by Arlen Oni on 5/1/26.
//

import SwiftUI

// MARK: - DrillColor

struct DrillColor: Identifiable, Hashable {
    let name: String
    let color: Color
    let textColor: Color

    var id: String { name }

    static func == (lhs: DrillColor, rhs: DrillColor) -> Bool { lhs.name == rhs.name }
    func hash(into hasher: inout Hasher) { hasher.combine(name) }

    static let available: [DrillColor] = [
        DrillColor(name: "Red",    color: .red,                                         textColor: .white),
        DrillColor(name: "Blue",   color: Color(red: 0.1, green: 0.3,  blue: 0.9),     textColor: .white),
        DrillColor(name: "Yellow", color: .yellow,                                      textColor: .black),
        DrillColor(name: "Green",  color: Color(red: 0.0, green: 0.72, blue: 0.18),    textColor: .white),
        DrillColor(name: "Orange", color: .orange,                                      textColor: .white),
        DrillColor(name: "White",  color: Color(white: 0.95),                           textColor: .black),
    ]
}

// MARK: - ColorCallConfig

struct ColorCallConfig {
    var reps: Int = 10
    var minRestSeconds: Int = 2
    var maxRestSeconds: Int = 5
    var manualAdvance: Bool = true
    var stimulusDuration: Int = 3
    var soundEnabled: Bool = true
    var activeColors: [DrillColor] = Array(DrillColor.available.prefix(4))
}

// MARK: - DrillResult

struct DrillResult {
    let repsCompleted: Int
    let totalReps: Int
    let elapsedSeconds: Int

    var formattedTime: String {
        let m = elapsedSeconds / 60
        let s = elapsedSeconds % 60
        return String(format: "%d:%02d", m, s)
    }
}
