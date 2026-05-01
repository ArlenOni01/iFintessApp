//
//  SoundPlayer.swift
//  TrainingApp
//
//  Created by Arlen Oni on 5/1/26.
//

import AVFoundation

class SoundPlayer: ObservableObject {
    private var player: AVAudioPlayer?

    func playWhistle() {
        guard let url = Bundle.main.url(
            forResource: "referee-blowing-whistle-sound-effect",
            withExtension: "mp3"
        ) else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}
