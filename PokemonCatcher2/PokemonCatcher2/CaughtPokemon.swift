//
//  CaughtPokemon.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//

import Foundation

struct CaughtPokemon: Identifiable, Codable {
    let id = UUID()
    let name: String
    let imageUrl: String
    var power: Int = Int.random(in: 50...150)
    let types: [String]  // типы покемона
      
      // Чтобы Codable работал корректно с let id = UUID()
      enum CodingKeys: String, CodingKey {
          case name, imageUrl, types
      }
  }

