//
//  DrillWorkouts.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/7/23.
//

import SwiftUI

struct DrillList {
    static let coneDrillWork: [SpecificList] = [
        .init(vidName: "cones", workoutName: "T-Drill", wkDescription: "Follow the following T-drill pattern.", isFaved: false, footworkPattern: .tDrill),
        .init(vidName: "cones", workoutName: "Box Drills", wkDescription: "Follow the following box drill patterns.", isFaved: false, footworkPattern: .boxDrill),
        .init(vidName: "cones", workoutName: "N-Drill", wkDescription: "Follow the following N-drill pattern.", isFaved: false, footworkPattern: .nDrill),
        .init(vidName: "cones", workoutName: "N-Drill Mirror", wkDescription: "Follow the following N-drill pattern, mirrored.", isFaved: false, footworkPattern: .nDrillMirror),
        .init(vidName: "cones", workoutName: "Z-Drill", wkDescription: "Follow the following Z-drill pattern.", isFaved: false, footworkPattern: .zDrill),
        .init(vidName: "cones", workoutName: "Z-Drill Mirror", wkDescription: "Follow the following Z-drill pattern, mirrored.", isFaved: false, footworkPattern: .zDrillMirror)
    ]
    
    static let coreStrengthWork: [SpecificList] = [
        .init(vidName: "core", workoutName: "Around the Worlds", wkDescription: "Grab Kettle bell and rotate around your body.", isFaved: false),
    ]
    
    static let explosivenessWork: [SpecificList] = [
        .init(vidName: "explosiveness", workoutName: "Ankle Flexion", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let ladderWork: [SpecificList] = [
        .init(vidName: "ladders", workoutName: "One Foot", wkDescription: "One foot in each hole on a sprint.", isFaved: false, ladderPattern: .oneFoot),
        .init(vidName: "ladders", workoutName: "Two Foot", wkDescription: "Right foot, then left foot, in each hole — a double-time run.", isFaved: false, ladderPattern: .twoFoot),
        .init(vidName: "ladders", workoutName: "TypeWriter", wkDescription: "Step in, then out, weaving side to side up the ladder.", isFaved: false, ladderPattern: .typeWriter),
        .init(vidName: "ladders", workoutName: "Backwards Typewriter", wkDescription: "The same weave, top to bottom, as if running it backwards.", isFaved: false, ladderPattern: .backwardsTypeWriter),
        .init(vidName: "ladders", workoutName: "Scissors", wkDescription: "Facing sideways, cross in and out down the ladder.", isFaved: false, ladderPattern: .scissors)
    ]
    
    static let lowerBodyWork: [SpecificList] = [
        .init(vidName: "lowerBody", workoutName: "Front Squats", wkDescription: "Hold bar on shoulders and keep heels on ground.", isFaved: false),
        .init(vidName: "lowerBody", workoutName: "Heel elevated Goblet Squats", wkDescription: "Elevate heels off the ground with a plate and squat.", isFaved: false)
    ]
    
    static let upperBodyWork: [SpecificList] = [
        .init(vidName: "upperBody", workoutName: "Landmine Rotation", wkDescription: "Rotate standing press overhead side to side.", isFaved: false)
    ]
}

