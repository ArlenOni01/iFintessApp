//
//  MobWorkouts.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/5/23.
//

import SwiftUI

struct WorkoutList {
    static let ankleWork: [SpecificList] = [
        .init(vidName: "ankle_flexion_start", workoutName: "Ankle Flexion", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false, vidName2: "ankle_flexion_finish"),
        .init(vidName: "heel_lifts_start", workoutName: "Heel lifts", wkDescription: "Keep heels on ground and lift up toes towards the ceiling.", isFaved: false, vidName2: "ankle"),
        .init(vidName: "ankle", workoutName: "Ankle Rotations", wkDescription: "Lift knee to 90 degrees and and rotate clockwise and counter-clockwise with ankles pointing down and twisting upwards.", isFaved: false, vidName2: "ankle_rotation_finish"),
        .init(vidName: "ankle", workoutName: "Standing Calf Wall Stretch", wkDescription: "Step one foot back and lean into the wall with your back heel pressed flat to stretch the calf and ankle.", isFaved: false, vidName2: "ankle"),
        .init(vidName: "ankle", workoutName: "Banded Ankle Dorsiflexion", wkDescription: "Loop a resistance band around your foot and pull your toes up toward your shin, then release.", isFaved: false, vidName2: "ankle")
    ]

    static let calisthenicWork: [SpecificList] = [
        .init(vidName: "pullup_start", workoutName: "Pull Ups", wkDescription: "Just pull up on the bar.", isFaved: false, vidName2: "pullup_finish"),
        .init(vidName: "calisthenics", workoutName: "Push-Ups", wkDescription: "Lower your chest to the floor keeping your body in a straight line, then press back up.", isFaved: false, vidName2: "calisthenics"),
        .init(vidName: "calisthenics", workoutName: "Bodyweight Squats", wkDescription: "Send your hips back and down until your thighs are parallel to the floor, then stand back up.", isFaved: false, vidName2: "calisthenics"),
        .init(vidName: "calisthenics", workoutName: "Triceps Dips", wkDescription: "Lower your body between two parallel bars by bending your elbows, then press back up.", isFaved: false, vidName2: "calisthenics")
    ]

    static let hipWork: [SpecificList] = [
        .init(vidName: "hips", workoutName: "Hip Abduction", wkDescription: "Use the machine.", isFaved: false, vidName2: "hips"),
        .init(vidName: "hips", workoutName: "Glute Bridge", wkDescription: "Lie on your back with knees bent and drive your hips up toward the ceiling, squeezing your glutes.", isFaved: false, vidName2: "hips"),
        .init(vidName: "hips", workoutName: "Clamshell", wkDescription: "Lying on your side with knees bent, open your top knee like a clamshell while keeping your feet together.", isFaved: false, vidName2: "hips"),
        .init(vidName: "hips", workoutName: "90/90 Hip Switch", wkDescription: "Sit with both legs bent at 90 degrees, one in front and one to the side, then rotate to switch sides.", isFaved: false, vidName2: "hips")
    ]

    static let kneeWork: [SpecificList] = [
        .init(vidName: "knee", workoutName: "Cycling", wkDescription: "Lie back and pedal an imaginary bike to mobilize the knees.", isFaved: false, vidName2: "knee"),
        .init(vidName: "knee", workoutName: "Heel Slides", wkDescription: "Lying on your back, slide one heel toward your glutes then slide it back out straight.", isFaved: false, vidName2: "knee"),
        .init(vidName: "knee", workoutName: "Straight Leg Raise", wkDescription: "Sit tall and extend one leg straight, then lift it a few inches off the ground.", isFaved: false, vidName2: "knee"),
        .init(vidName: "knee", workoutName: "Wall Sit", wkDescription: "Slide your back down a wall until your knees are bent at 90 degrees and hold.", isFaved: false, vidName2: "knee")
    ]

    static let lowerLegWork: [SpecificList] = [
        .init(vidName: "lowerLeg", workoutName: "Single Legged Hops", wkDescription: "Hop in place on one leg to build lower leg control.", isFaved: false, vidName2: "lowerLeg"),
        .init(vidName: "lowerLeg", workoutName: "Standing Calf Raise", wkDescription: "Rise up onto the balls of your feet as high as you can, then lower back down.", isFaved: false, vidName2: "lowerLeg"),
        .init(vidName: "lowerLeg", workoutName: "Lunging Calf Stretch", wkDescription: "Step one foot back into a lunge, keeping the back heel pressed down to stretch the calf.", isFaved: false, vidName2: "lowerLeg"),
        .init(vidName: "lowerLeg", workoutName: "Eccentric Heel Drop", wkDescription: "Stand on the edge of a step on the balls of your feet and slowly lower your heels below the step.", isFaved: false, vidName2: "lowerLeg")
    ]

    static let shoulderWork: [SpecificList] = [
        .init(vidName: "shoulder_cuff_rotation_start", workoutName: "Shoulder Cuff rotations", wkDescription: "Rotate the arm through its full range to mobilize the rotator cuff.", isFaved: false, vidName2: "shoulder_cuff_rotation_finish"),
        .init(vidName: "shoulders", workoutName: "Band Pass-Through", wkDescription: "Holding a resistance band with a wide grip, raise it overhead and pass it behind your back, then bring it back to the front.", isFaved: false, vidName2: "shoulders"),
        .init(vidName: "shoulders", workoutName: "Wall Slide Y-Raise", wkDescription: "With your back against a wall, slide your arms up into a Y shape, keeping elbows and wrists touching the wall.", isFaved: false, vidName2: "shoulders"),
        .init(vidName: "shoulders", workoutName: "Doorway Shoulder Stretch", wkDescription: "Place your forearm on a doorframe and gently lean forward to stretch the front of the shoulder.", isFaved: false, vidName2: "shoulders")
    ]

    static let wristWork: [SpecificList] = [
        .init(vidName: "wrist", workoutName: "Wrist Flexion", wkDescription: "Bend the wrist forward and back through its full range.", isFaved: false, vidName2: "wrist"),
        .init(vidName: "wrist", workoutName: "Wrist Extension", wkDescription: "Extend your arm and gently pull your fingers back toward you with the opposite hand.", isFaved: false, vidName2: "wrist"),
        .init(vidName: "wrist", workoutName: "Prayer Stretch", wkDescription: "Press your palms together in front of your chest, then lower your hands toward your waist keeping palms together.", isFaved: false, vidName2: "wrist"),
        .init(vidName: "wrist", workoutName: "Wall Wrist Walk", wkDescription: "Place your hands on a wall with fingers pointing up and walk them down as far as you can, then walk them back up.", isFaved: false, vidName2: "wrist")
    ]

    static let yogaWork: [SpecificList] = [
        .init(vidName: "yoga", workoutName: "Downward Dog", wkDescription: "Form an inverted V, pressing heels toward the floor.", isFaved: false, vidName2: "yoga"),
        .init(vidName: "yoga", workoutName: "Cat-Cow", wkDescription: "On hands and knees, arch your back and drop your belly (cow), then round your spine and tuck your chin (cat).", isFaved: false, vidName2: "yoga"),
        .init(vidName: "yoga", workoutName: "Child's Pose", wkDescription: "Kneel and sit back onto your heels, then fold forward with arms extended in front of you.", isFaved: false, vidName2: "yoga"),
        .init(vidName: "yoga", workoutName: "Low Lunge", wkDescription: "Step one foot forward into a deep lunge and reach your arms overhead to open the hips.", isFaved: false, vidName2: "yoga")
    ]
}
