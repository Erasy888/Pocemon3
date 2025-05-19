//
//  PokemonStorage.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import Foundation

class PokemonStorage {
    static let shared = PokemonStorage()
    private let key = "caughtPokemons"

    func save(pokemon: CaughtPokemon) {
        var current = loadAll()
        current.append(pokemon)
        if let data = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func saveAll(_ pokemons: [CaughtPokemon]) {
        if let data = try? JSONEncoder().encode(pokemons) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadAll() -> [CaughtPokemon] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let pokemons = try? JSONDecoder().decode([CaughtPokemon].self, from: data)
        else {
            return []
        }
        return pokemons
    }

    func update(pokemon: CaughtPokemon) {
        var pokemons = loadAll()
        if let index = pokemons.firstIndex(where: { $0.name == pokemon.name }) {
            pokemons[index] = pokemon
            saveAll(pokemons)
        }
    }
}

func attemptCatch(pokemon: CaughtPokemon, with ball: PokeballType) -> Bool {
    let success = Double.random(in: 0...1) <= ball.catchChance
    if success {
        PokemonStorage.shared.save(pokemon: pokemon)
    }
    return success
}

func trainPokemon(_ pokemon: inout CaughtPokemon) {
    pokemon.power += Int.random(in: 1...5)
    PokemonStorage.shared.update(pokemon: pokemon)
}

func battle(myPokemon: CaughtPokemon, opponent: CaughtPokemon) -> String {
    if myPokemon.power > opponent.power {
        return "🎉 Победа!"
    } else if myPokemon.power < opponent.power {
        return "😢 Поражение..."
    } else {
        return "🤝 Ничья!"
    }
}
