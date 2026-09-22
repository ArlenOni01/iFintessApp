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
        .init(vidName: "around_the_world_start", workoutName: "Around the Worlds", wkDescription: "Grab Kettle bell and rotate around your body.", isFaved: false, vidName2: "around_the_world_finish"),
        .init(vidName: "plank_start", workoutName: "Plank", wkDescription: "Hold a straight line from head to heels, supported on your forearms and toes.", isFaved: false, vidName2: "plank_finish"),
        .init(vidName: "dead_bug_start", workoutName: "Dead Bug", wkDescription: "Lying on your back with arms and knees raised, extend one arm and the opposite leg toward the floor, then switch.", isFaved: false, vidName2: "dead_bug_finish"),
        .init(vidName: "pallof_press_start", workoutName: "Pallof Press", wkDescription: "Holding a band or cable at your chest, press your arms straight out in front of you and resist rotating.", isFaved: false, vidName2: "pallof_press_finish")
    ]

    static let explosivenessWork: [SpecificList] = [
        .init(vidName: "box_jump_start", workoutName: "Box Jump", wkDescription: "Dip into a quarter squat and jump explosively onto a raised box, landing softly with bent knees.", isFaved: false, vidName2: "box_jump_finish"),
        .init(vidName: "jump_squat_start", workoutName: "Jump Squat", wkDescription: "Drop into a squat and explode upward into a jump, landing softly back into the squat.", isFaved: false, vidName2: "jump_squat_finish"),
        .init(vidName: "medicine_ball_slam_start", workoutName: "Medicine Ball Slam", wkDescription: "Raise a medicine ball overhead and slam it into the ground as hard as possible.", isFaved: false, vidName2: "medicine_ball_slam_finish")
    ]
    
    static let ladderWork: [SpecificList] = [
        .init(vidName: "ladders", workoutName: "One Foot", wkDescription: "One foot in each hole on a sprint.", isFaved: false, ladderPattern: .oneFoot),
        .init(vidName: "ladders", workoutName: "Two Foot", wkDescription: "Right foot, then left foot, in each hole — a double-time run.", isFaved: false, ladderPattern: .twoFoot),
        .init(vidName: "ladders", workoutName: "TypeWriter", wkDescription: "Step in, then out, weaving side to side up the ladder.", isFaved: false, ladderPattern: .typeWriter),
        .init(vidName: "ladders", workoutName: "Backwards Typewriter", wkDescription: "The same weave, top to bottom, as if running it backwards.", isFaved: false, ladderPattern: .backwardsTypeWriter),
        .init(vidName: "ladders", workoutName: "Scissors", wkDescription: "Facing sideways, cross in and out down the ladder.", isFaved: false, ladderPattern: .scissors)
    ]
    
    static let lowerBodyWork: [SpecificList] = [
        .init(vidName: "front_squat_start", workoutName: "Front Squats", wkDescription: "Hold bar on shoulders and keep heels on ground.", isFaved: false, vidName2: "front_squat_finish"),
        .init(vidName: "heel_elevated_goblet_squats_start", workoutName: "Heel elevated Goblet Squats", wkDescription: "Elevate heels off the ground with a plate and squat.", isFaved: false, vidName2: "heel_elevated_goblet_squats_finish"),
        .init(vidName: "romanian_deadlift_start", workoutName: "Romanian Deadlift", wkDescription: "Holding a barbell, hinge at the hips and lower it down your shins, keeping your back flat, then stand back up.", isFaved: false, vidName2: "romanian_deadlift_finish"),
        .init(vidName: "bulgarian_split_squat_start", workoutName: "Bulgarian Split Squat", wkDescription: "With your back foot elevated behind you on a bench, lower into a lunge on your front leg, then press back up.", isFaved: false, vidName2: "bulgarian_split_squat_finish")
    ]

    static let upperBodyWork: [SpecificList] = [
        .init(vidName: "landmine_press_start", workoutName: "Landmine Rotation", wkDescription: "Rotate standing press overhead side to side.", isFaved: false, vidName2: "landmine_press_finish"),
        .init(vidName: "bench_press_start", workoutName: "Bench Press", wkDescription: "Lying on a bench, lower the barbell to your chest, then press it back up to full extension.", isFaved: false, vidName2: "bench_press_finish"),
        .init(vidName: "lat_pulldown_start", workoutName: "Lat Pulldown", wkDescription: "Grip the bar wide and pull it down to your chest, then let it rise back up with control.", isFaved: false, vidName2: "lat_pulldown_finish"),
        .init(vidName: "overhead_press", workoutName: "Overhead Press", wkDescription: "Press a barbell from your shoulders straight overhead until your arms are fully extended.", isFaved: false)
    ]
}

