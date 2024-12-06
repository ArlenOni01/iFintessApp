//
//  FullTimer.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/7/24.
//

//If you want to see the backtrace, please set CG_NUMERICS_SHOW_BACKTRACE environmental variable.

import SwiftUI
import Combine

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TimerPage: View {
    @State private var reps: Int = 3
    @State private var setTime: Int = 45
    @State private var minRestTime: Int = 60
    @State private var maxRestTime: Int = 120
    @State private var currentRep: Int = 0
    @State private var activeTimeRemaining: Int = 0
    @State private var restTimeRemaining: Int = 0
    @State private var isResting: Bool = false
    @State private var isRunning: Bool = false
    
    @State private var timer: AnyCancellable?
    
    var body: some View {
        TabView {
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.3, green: 0.6, blue: 0.8), Color.teal.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        UIApplication.shared.endEditing() // Dismiss keyboard
                    }
                
                VStack(spacing: 20) {
                    Text("Timer")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    HStack{
                        VStack{
                            Text("Reps")
                            TextField("Enter reps", value: $reps, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                            
                            Text("Min Rest (seconds)")
                            TextField("Enter min rest time", value: $minRestTime, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                        }
                        
                        VStack{
                            Text("Set Time (seconds)")
                            TextField("Enter set time", value: $setTime, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                            
                            Text("Max Rest (seconds)")
                            TextField("Enter max rest time", value: $maxRestTime, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                        }
                    }
                    
                    if isRunning {
                        Text(isResting ? "Rest Time: \(restTimeRemaining)" : "Set Time: \(activeTimeRemaining)")
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Button(isRunning ? "Stop Timer" : "Start Timer") {
                        if isRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    }
                    .font(.title)
                    .padding()
                }
                .padding()
                .background(Color.white.opacity(0.7)) // Semi-transparent background
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // Apply rounded clipping
                .shadow(radius: 10) // Optional: Add a shadow for depth
                .padding()
                
                Spacer()
            }
            
            
            
            // Secondary View
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.3, green: 0.6, blue: 0.8), Color.teal.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    VStack {
                        HStack {
                            Spacer() // Pushes the menu to the right
                            Menu("Change Options") {
                                Button("Numbers") {
                                    print("Option One selected")
                                }
                                Button("Colors") {
                                    print("Option Two selected")
                                }
                                Button("Directions") {
                                    print("Option Three selected")
                                }
                            }
                            .padding(.bottom)
                            .foregroundColor(.black)
                        }
                        .padding(.trailing)
                    }
                    
                    Text("Reactions")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    HStack{
                        VStack{
                            Text("Reps")
                            TextField("Enter reps", value: $reps, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                            
                            Text("Min Rest (seconds)")
                            TextField("Enter min rest time", value: $minRestTime, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                        }
                        
                        VStack{
                            Text("Set Time (seconds)")
                            TextField("Enter set time", value: $setTime, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                            
                            Text("Max Rest (seconds)")
                            TextField("Enter max rest time", value: $maxRestTime, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                        }
                    }
                    
                    if isRunning {
                        Text(isResting ? "Rest Time: \(restTimeRemaining)" : "Set Time: \(activeTimeRemaining)")
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Button(isRunning ? "Stop Timer" : "Start Timer") {
                        if isRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    }
                    .font(.title)
                    .padding()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(1..<10) { index in
                                Text("Another Tab Content \(index)")
                                    .padding()
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .background(Color.white.opacity(0.7)) // Semi-transparent background
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // Apply rounded clipping
                .shadow(radius: 10) // Optional: Add a shadow for depth
                .padding()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.all)// Enable swiping between pages
    }
    
    // Start the timer logic
    func startTimer() {
        isRunning = true
        currentRep = reps
        startActiveTimer()
    }
    
    // Stop the timer
    func stopTimer() {
        isRunning = false
        timer?.cancel()
    }
    
    // Timer for the active workout set
    func startActiveTimer() {
        activeTimeRemaining = setTime
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            if self.activeTimeRemaining > 0 {
                self.activeTimeRemaining -= 1
            } else {
                self.currentRep -= 1
                if self.currentRep > 0 {
                    self.startRestTimer()
                } else {
                    self.stopTimer()
                }
            }
        }
    }
    
    // Timer for the rest period
    func startRestTimer() {
        isResting = true
        restTimeRemaining = Int.random(in: minRestTime...maxRestTime)
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            if self.restTimeRemaining > 0 {
                self.restTimeRemaining -= 1
            } else {
                self.isResting = false
                self.startActiveTimer()
            }
        }
    }
}

#Preview {
    TimerPage()
}
