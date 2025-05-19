//
//  TrainingView.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//

import SwiftUI



struct TrainingView: View {
    @State private var pokemons: [CaughtPokemon] = PokemonStorage.shared.loadAll()

    var body: some View {
        List {
            ForEach(pokemons.indices, id: \.self) { index in
                var pokemon = pokemons[index]

                HStack {
                    Text(pokemon.name.capitalized)
                    Spacer()
                    Text("💪 \(pokemon.power)")
                    Button("Тренировать") {
                        trainPokemon(&pokemon)
                        pokemons[index] = pokemon
                    }
                }
            }
        }
        .navigationTitle("Тренировка")
    }
}
