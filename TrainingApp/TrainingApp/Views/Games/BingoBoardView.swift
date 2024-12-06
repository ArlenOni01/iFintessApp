//
//  Bingo.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/5/24.
//

import SwiftUI

struct BingoTile: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct BingoBoardView: View {
    // Initialize a 5x5 grid of fitness challenges
    @State private var tiles: [BingoTile] = [
        BingoTile(title: "10 Squats"), BingoTile(title: "20 Jumping Jacks"), BingoTile(title: "15-second Plank"),
        BingoTile(title: "30 Lunges"), BingoTile(title: "1-min Wall Sit"), BingoTile(title: "20 Push-ups"),
        BingoTile(title: "10 Burpees"), BingoTile(title: "20 Mountain Climbers"), BingoTile(title: "15 Jump Squats"),
        BingoTile(title: "40-second Plank"), BingoTile(title: "10 High Knees"), BingoTile(title: "30-second Wall Sit"),
        BingoTile(title: "20 Crunches"), BingoTile(title: "25 Squats"), BingoTile(title: "15 Push-ups"),
        BingoTile(title: "50 Jumping Jacks"), BingoTile(title: "10-second Hold Squat"), BingoTile(title: "15 Lunges"),
        BingoTile(title: "20 Bicycle Crunches"), BingoTile(title: "15-second Plank"), BingoTile(title: "10 Tricep Dips"),
        BingoTile(title: "5 Burpees"), BingoTile(title: "1-min Jog"), BingoTile(title: "15-second Balance Hold"),
        BingoTile(title: "30 Arm Circles")
    ]
    
    @State private var showBingoAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Fitness Bingo")
                    .font(.largeTitle)
                    .padding()
                
                // Displaying the 5x5 grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 8) {
                    ForEach(tiles.indices, id: \.self) { index in
                        Button(action: {
                            tiles[index].isCompleted.toggle() // Mark tile as complete
                            if checkForBingo() {
                                showBingoAlert = true
                            }
                        }) {
                            Text(tiles[index].title)
                                .frame(maxWidth: .infinity, minHeight: 70)
                                .font(.system(size: 12)) // Set font size to 12
                                .background(tiles[index].isCompleted ? Color.mint : Color.indigo)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
            .alert(isPresented: $showBingoAlert) {
                Alert(title: Text("Bingo!"), message: Text("Congratulations! You completed a row, column, or diagonal!"), dismissButton: .default(Text("OK")))
        }
    }
}
    
    func checkForBingo() -> Bool {
        let gridSize = 5
        
        // Check rows
        for row in 0..<gridSize {
            let startIndex = row * gridSize
            if (0..<gridSize).allSatisfy({ tiles[startIndex + $0].isCompleted }) {
                return true
            }
        }
        
        // Check columns
        for col in 0..<gridSize {
            if (0..<gridSize).allSatisfy({ tiles[col + $0 * gridSize].isCompleted }) {
                return true
            }
        }
        
        // Check diagonals
        if (0..<gridSize).allSatisfy({ tiles[$0 * gridSize + $0].isCompleted }) {
            return true
        }
        if (0..<gridSize).allSatisfy({ tiles[($0 + 1) * gridSize - ($0 + 1)].isCompleted }) {
            return true
        }
        
        return false
    }
}

#Preview {
    BingoBoardView()
}
