//
//  LadderPattern.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/8/26.
//

import Foundation

/// One foot's placement within a ladder square.
struct LadderFootPlacement: Hashable {
    let foot: FootSide
    /// Horizontal offset within the square, as a fraction of its width from
    /// center: 0 = centered, -0.5 = left edge, 0.5 = right edge. Drills that
    /// place a foot outside the ladder (e.g. Scissors) can go past ±0.5.
    let xOffset: CGFloat

    init(_ foot: FootSide, xOffset: CGFloat = 0) {
        self.foot = foot
        self.xOffset = xOffset
    }
}

/// One beat in a ladder drill: which square (rung index, 0-based, with 0
/// always drawn at the top of the ladder), which foot placement(s) land
/// there, and the coaching cue. By convention a drill's steps run from the
/// highest index (bottom, the start) to 0 (top) — bottom-to-top — unless
/// the drill specifically calls for a different direction.
struct LadderStep: Hashable {
    let squareIndex: Int
    let placements: [LadderFootPlacement]
    let action: String
}

/// A full, loopable ladder drill sequence, drawn over a vertical ladder of
/// `squareCount` rungs.
struct LadderPattern: Hashable {
    let squareCount: Int
    let steps: [LadderStep]

    /// One foot per square, alternating left/right up the ladder from the
    /// bottom. Each foot lands slightly toward its own side of the square
    /// (mirroring how the cone drills place left/right feet) rather than
    /// dead-center, so it reads like a real running stride rather than
    /// hopping straight up the middle.
    static let oneFoot = LadderPattern(
        squareCount: 6,
        steps: stride(from: 5, through: 0, by: -1).enumerated().map { order, squareIndex in
            let foot: FootSide = order.isMultiple(of: 2) ? .left : .right
            let xOffset: CGFloat = foot == .left ? -0.22 : 0.22
            return LadderStep(
                squareIndex: squareIndex,
                placements: [LadderFootPlacement(foot, xOffset: xOffset)],
                action: foot == .left ? "Left Foot" : "Right Foot"
            )
        }
    )
}
