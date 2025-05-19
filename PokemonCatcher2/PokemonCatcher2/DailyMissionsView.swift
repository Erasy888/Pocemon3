//
//  DailyMissionsView.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//

import SwiftUI

struct DailyMissionsView: View {
    let missions = [
        "🎯 Поймай водного покемона",
        "🌟 Поймай редкого покемона (ID > 130)",
        "⚡ Найди электрического покемона"
    ]

    var body: some View {
        List(missions, id: \.self) { mission in
            Text(mission)
        }
        .navigationTitle("🗓️ Ежедневные миссии")
    }
}
