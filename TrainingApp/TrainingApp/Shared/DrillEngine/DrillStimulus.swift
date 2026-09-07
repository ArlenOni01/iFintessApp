//
//  DrillStimulus.swift
//  TrainingApp
//

import SwiftUI

// One shape for what any drill (Color/Number/Direction Call) shows and speaks,
// so a single engine and active view can drive all three.
struct DrillStimulus: Identifiable, Hashable {
    let id: String
    let spokenText: String
    let displayText: String
    let displayColor: Color?
    let symbol: String?
    let textColor: Color

    static func == (lhs: DrillStimulus, rhs: DrillStimulus) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

extension DrillColor {
    var asStimulus: DrillStimulus {
        DrillStimulus(
            id: "color-\(name)",
            spokenText: name,
            displayText: name.uppercased(),
            displayColor: color,
            symbol: nil,
            textColor: textColor
        )
    }
}

extension DirectionStimulus {
    var asStimulus: DrillStimulus {
        DrillStimulus(
            id: "direction-\(name)",
            spokenText: name,
            displayText: name.uppercased(),
            displayColor: nil,
            symbol: symbol,
            textColor: .white
        )
    }
}

extension NumberCallConfig {
    var stimulusPool: [DrillStimulus] {
        (1...max(1, coneCount)).map { number in
            DrillStimulus(
                id: "number-\(number)",
                spokenText: "\(number)",
                displayText: "\(number)",
                displayColor: nil,
                symbol: nil,
                textColor: .white
            )
        }
    }
}
