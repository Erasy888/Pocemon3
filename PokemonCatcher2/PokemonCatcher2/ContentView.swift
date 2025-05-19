//
//  ContentView.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showEffect = false
    @State private var player: AVAudioPlayer?

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image("pokeball")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaleEffect(showEffect ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: showEffect)
                    .onTapGesture {
                        showEffect = true
                        playCatchSound()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showEffect = false
                        }
                    }

                // Навигационные ссылки
                NavigationLink("🔍 Найти покемона", destination: FindPokemonView())
                NavigationLink("📦 Коллекция", destination: PokemonCollectionView())
                NavigationLink("🗓️ Миссии", destination: DailyMissionsView())
                NavigationLink("💪 Тренировка", destination: TrainingView()) // ✅ Добавлено
                NavigationLink("⚔️ Битва", destination: BattleView())         // ✅ Добавлено
            }
            .navigationTitle("Pokemon Ловля")
        }
    }

    func playCatchSound() {
        guard let url = Bundle.main.url(forResource: "catch", withExtension: "mp3") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}

