//
//  PokemonCollectionView.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import SwiftUI

struct PokemonCollectionView: View {
    @State private var pokemons: [CaughtPokemon] = PokemonStorage.shared.loadAll()
    @State private var selectedType: String = "all"
    
    let allTypes = ["all", "water", "fire", "grass", "electric"]

    var filteredPokemons: [CaughtPokemon] {
        if selectedType == "all" {
            return pokemons
        } else {
            return pokemons.filter { $0.types.contains(selectedType) }
        }
    }

    var body: some View {
        VStack {
            // 🔘 Picker для фильтрации
            Picker("Тип", selection: $selectedType) {
                ForEach(allTypes, id: \.self) { type in
                    Text(type.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // 📋 Список покемонов
            List(filteredPokemons) { pokemon in
                HStack {
                    AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }

                    Text(pokemon.name.capitalized)
                        .font(.headline)

                    Spacer()
                }
            }
        }
        .navigationTitle("Коллекция")
        .onAppear {
            pokemons = PokemonStorage.shared.loadAll()
        }
    }
}
