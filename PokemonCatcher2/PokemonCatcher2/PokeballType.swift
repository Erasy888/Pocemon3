//
//  PokeballType.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//

import Foundation

enum PokeballType: String, CaseIterable, Codable {
    case pokeball, superball, ultraball

    var catchChance: Double {
        switch self {
        case .pokeball: return 0.4
        case .superball: return 0.7
        case .ultraball: return 0.9
        }
    }

    var displayName: String {
        switch self {
        case .pokeball: return "Обычный"
        case .superball: return "Супер"
        case .ultraball: return "Ультра"
        }
    }
}

func getRandomPokeball() -> PokeballType {
    return PokeballType.allCases.randomElement()!
}
