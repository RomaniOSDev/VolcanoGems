//
//  ContentView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigation = NavigationManager()
    var body: some View {
        NavigationStack(path: $navigation.path) {
            StartView()
                .environmentObject(navigation)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .settings: SettingsView()
                    case .mades:  ModesView()
                    case .brain: BrainView()
                    case .facts: FactsView()
                    case .math: MatchView()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
