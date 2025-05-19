//
//  FindPokemonView.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import SwiftUI
import AVFoundation

struct FindPokemonView: View {
    @State private var currentPokemon = CaughtPokemon(
        name: "Pikachu",
        imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
        types: ["electric"]
    )
    @State private var showEffect = false
    @State private var catchResult: String = ""
    @State private var player: AVAudioPlayer?
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            Text(currentPokemon.name.capitalized)
                .font(.title)

            AsyncImage(url: URL(string: currentPokemon.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .scaleEffect(showEffect ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.3), value: showEffect)

            HStack {
                ForEach(currentPokemon.types, id: \.self) { type in
                    Text(type.capitalized)
                        .padding(6)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }

            Button("🔍 Найти покемона") {
                fetchRandomPokemon()
            }
            .disabled(isLoading)

            Button("🎯 Поймать") {
                let pokeball = getRandomPokeball()

                showEffect = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showEffect = false
                }

                if attemptCatch(pokemon: currentPokemon, with: pokeball) {
                    playCatchSound() // 🔊 Воспроизведение звука при успехе
                    catchResult = "🎉 Пойман с помощью \(pokeball.displayName)!"
                } else {
                    catchResult = "❌ \(currentPokemon.name.capitalized) сбежал!"
                }
            }

            Text(catchResult)
                .foregroundColor(.gray)
                .padding()
        }
        .padding()
        .navigationTitle("Поимка")
    }

    func playCatchSound() {
        guard let url = Bundle.main.url(forResource: "catch", withExtension: "mp3") else {
            print("❌ catch.mp3 не найден в проекте")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("❌ Ошибка при воспроизведении звука: \(error)")
        }
    }

    func fetchRandomPokemon() {
        isLoading = true
        catchResult = ""

        let randomID = Int.random(in: 1...151)
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    isLoading = false
                }
                return
            }

            if let decoded = try? JSONDecoder().decode(PokeAPIResponse.self, from: data) {
                DispatchQueue.main.async {
                    isLoading = false
                    let types = decoded.types.map { $0.type.name }
                    let pokemon = CaughtPokemon(
                        name: decoded.name,
                        imageUrl: decoded.sprites.front_default,
                        types: types
                    )
                    currentPokemon = pokemon
                }
            } else {
                DispatchQueue.main.async {
                    isLoading = false
                }
            }
        }.resume()
    }
}
