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

    /// A "double time" version of One Foot: still running (not hopping), but
    /// the right foot then the left foot each touch down in turn within the
    /// same square before advancing to the next square, bottom-to-top.
    static let twoFoot = LadderPattern(
        squareCount: 6,
        steps: stride(from: 5, through: 0, by: -1).flatMap { squareIndex in
            [
                LadderStep(
                    squareIndex: squareIndex,
                    placements: [LadderFootPlacement(.right, xOffset: 0.22)],
                    action: "Right Foot"
                ),
                LadderStep(
                    squareIndex: squareIndex,
                    placements: [LadderFootPlacement(.left, xOffset: -0.22)],
                    action: "Left Foot"
                )
            ]
        }
    )

    /// A weaving slalom up the ladder. In each box both feet step to their
    /// own side of the interior, then both step back out — but the leading
    /// foot and the side stepped out to alternate box to box, so the athlete
    /// zigzags side to side as they climb the ladder.
    static let typeWriter = LadderPattern(
        squareCount: 6,
        steps: stride(from: 5, through: 0, by: -1).enumerated().flatMap { box, squareIndex -> [LadderStep] in
            let enteringFromLeft = box.isMultiple(of: 2)
            let leadFoot: FootSide = enteringFromLeft ? .right : .left
            let trailFoot: FootSide = enteringFromLeft ? .left : .right
            let sign: CGFloat = enteringFromLeft ? 1 : -1
            // The lead foot steps out a little wider than the trailing foot,
            // so once both are outside the ladder they land side by side
            // rather than stacked on the exact same spot.
            let leadOutXOffset = sign * 1.05
            let trailOutXOffset = sign * 0.75

            func inXOffset(_ foot: FootSide) -> CGFloat { foot == .right ? 0.22 : -0.22 }
            func label(_ foot: FootSide, _ verb: String) -> String { "\(foot == .right ? "Right" : "Left") \(verb)" }

            return [
                LadderStep(squareIndex: squareIndex, placements: [LadderFootPlacement(leadFoot, xOffset: inXOffset(leadFoot))], action: label(leadFoot, "In")),
                LadderStep(squareIndex: squareIndex, placements: [LadderFootPlacement(trailFoot, xOffset: inXOffset(trailFoot))], action: label(trailFoot, "In")),
                LadderStep(squareIndex: squareIndex, placements: [LadderFootPlacement(leadFoot, xOffset: leadOutXOffset)], action: label(leadFoot, "Out")),
                LadderStep(squareIndex: squareIndex, placements: [LadderFootPlacement(trailFoot, xOffset: trailOutXOffset)], action: label(trailFoot, "Out"))
            ]
        }
    )
}
