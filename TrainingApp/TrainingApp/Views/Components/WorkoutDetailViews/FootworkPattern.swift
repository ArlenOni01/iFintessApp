//
//  FootworkPattern.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/7/26.
//

import Foundation

/// A position on the 8-cone agility square (3x3 grid with the center left empty).
enum FootworkGridPoint: CaseIterable, Hashable {
    case topLeft, topMid, topRight
    case midLeft, midRight
    case bottomLeft, bottomMid, bottomRight

    /// Unit-space position (0...1) within the square, where y increases downward
    /// (top = far/forward from the athlete, bottom = the starting cone).
    var unitPoint: CGPoint {
        let cols: [CGFloat] = [0.14, 0.5, 0.86]
        let rows: [CGFloat] = [0.12, 0.5, 0.88]
        switch self {
        case .topLeft: return CGPoint(x: cols[0], y: rows[0])
        case .topMid: return CGPoint(x: cols[1], y: rows[0])
        case .topRight: return CGPoint(x: cols[2], y: rows[0])
        case .midLeft: return CGPoint(x: cols[0], y: rows[1])
        case .midRight: return CGPoint(x: cols[2], y: rows[1])
        case .bottomLeft: return CGPoint(x: cols[0], y: rows[2])
        case .bottomMid: return CGPoint(x: cols[1], y: rows[2])
        case .bottomRight: return CGPoint(x: cols[2], y: rows[2])
        }
    }
}

enum FootSide: Hashable {
    case left, right
}

/// One beat in a footwork sequence: which cone the athlete is driving toward,
/// which foot leads the movement, and the coaching cue to display.
struct FootworkStep: Hashable {
    let point: FootworkGridPoint
    let leadFoot: FootSide
    let action: String
}

/// A full, loopable footwork pattern drawn over the 8-cone agility square.
struct FootworkPattern: Hashable {
    /// The cones that are actually used by this specific drill (others are
    /// rendered as faint reference dots so the square stays recognizable).
    let activeCones: [FootworkGridPoint]
    let steps: [FootworkStep]

    static let boxDrill = FootworkPattern(
        activeCones: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        steps: [
            FootworkStep(point: .bottomLeft, leadFoot: .right, action: "Start"),
            FootworkStep(point: .topLeft, leadFoot: .left, action: "Sprint Forward"),
            FootworkStep(point: .topRight, leadFoot: .right, action: "Shuffle Right"),
            FootworkStep(point: .bottomRight, leadFoot: .left, action: "Backpedal"),
            FootworkStep(point: .bottomLeft, leadFoot: .right, action: "Shuffle Left")
        ]
    )

    static let tDrill = FootworkPattern(
        activeCones: [.bottomMid, .topMid, .topLeft, .topRight],
        steps: [
            FootworkStep(point: .bottomMid, leadFoot: .right, action: "Start"),
            FootworkStep(point: .topMid, leadFoot: .left, action: "Sprint Forward"),
            FootworkStep(point: .topLeft, leadFoot: .right, action: "Shuffle Left"),
            FootworkStep(point: .topRight, leadFoot: .left, action: "Shuffle Right"),
            FootworkStep(point: .topMid, leadFoot: .right, action: "Shuffle Left"),
            FootworkStep(point: .bottomMid, leadFoot: .left, action: "Backpedal")
        ]
    )
}
