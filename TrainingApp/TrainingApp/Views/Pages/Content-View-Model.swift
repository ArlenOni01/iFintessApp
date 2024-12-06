//
//  Content-View-Model.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/14/23.
//

import Foundation

extension TimerPage {
    final class ViewModel: ObservableObject {
        @Published var isActive = false
        @Published var soundOff = false
        @Published var time: String = "00:00"
        
        let timer = Timer.publish(every: 1,
                                  on: .main,
                                  in: .common).autoconnect()
        
        func convertSecondsToTime(timeInSeconds : Int) -> String {
            let minutes = timeInSeconds / 60
            
            let seconds = timeInSeconds % 60
            
            return String(format: "%02i:%02i",
            minutes,
            seconds)
        }
    }
}
