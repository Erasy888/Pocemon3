//
//  BattleView.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import SwiftUI

struct BattleView: View {
    @State private var myPokemons: [CaughtPokemon] = PokemonStorage.shared.loadAll()
    @State private var selectedPokemon: CaughtPokemon?
    @State private var opponent: CaughtPokemon?
    @State private var result: String = ""

    var body: some View {
        VStack {
            Text("Выберите своего покемона")
                .font(.headline)

            List {
                ForEach(myPokemons) { pokemon in
                    Button(pokemon.name.capitalized) {
                        selectedPokemon = pokemon
                        opponent = getRandomOpponent()
                        if let my = selectedPokemon, let enemy = opponent {
                            result = battle(myPokemon: my, opponent: enemy)
                        }
                    }
                }
            }

            if let my = selectedPokemon, let enemy = opponent {
                VStack(spacing: 10) {
                    Text("⚔️ \(my.name.capitalized) vs \(enemy.name.capitalized)")
                    Text(result).font(.title2)
                }.padding()
            }
        }
        .navigationTitle("Битва")
    }

    func getRandomOpponent() -> CaughtPokemon {
        let names = ["Bulbasaur", "Charmander", "Squirtle"]
        let powers = [5, 10, 7]
        let i = Int.random(in: 0..<names.count)
        return CaughtPokemon(name: names[i], imageUrl: "", power: powers[i], types: [])
    }
}
