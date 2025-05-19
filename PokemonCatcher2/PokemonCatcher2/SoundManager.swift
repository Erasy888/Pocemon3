//
//  SoundManager.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//

import AVFoundation

var player: AVAudioPlayer?

func playCatchSound() {
    guard let url = Bundle.main.url(forResource: "catch", withExtension: "mp3") else { return }
    player = try? AVAudioPlayer(contentsOf: url)
    player?.play()
}
