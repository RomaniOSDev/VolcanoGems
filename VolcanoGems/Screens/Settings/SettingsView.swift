//
//  SettingsView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @StateObject private var statisticsManager = GameStatisticsManager.shared
    @State private var terms = "https://www.termsfeed.com/live/c0fef907-0ef7-417d-993e-c442a052b522"
    @State private var privacy = "https://www.termsfeed.com/live/d41592d6-22fc-4001-a733-4b8d9a9b9f1d"
    @State private var showResetAlert = false
    
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    Text("SETTINGS")
                        .foregroundStyle(.white)
                        .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    
                    //MARK: - Statistics Section
                    VStack(spacing: 15) {
                        Text("STATISTICS")
                            .foregroundStyle(.white)
                            .font(.system(size: 28, weight: .bold, design: .monospaced))
                        
                        // Brain Statistics
                        VStack(alignment: .leading, spacing: 8) {
                            Text("BRAIN GAME")
                                .foregroundStyle(.yellow)
                                .font(.system(size: 20, weight: .semibold, design: .monospaced))
                            
                            HStack {
                                Text("Total Games:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                Spacer()
                                Text("\(statisticsManager.statistics.brainTotalGames)")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                            
                            HStack {
                                Text("Wins:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                Spacer()
                                Text("\(statisticsManager.statistics.brainWins)")
                                    .foregroundStyle(.green)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                            
                            HStack {
                                Text("Losses:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                Spacer()
                                Text("\(statisticsManager.statistics.brainLosses)")
                                    .foregroundStyle(.red)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(15)
                        
                        // Match Statistics
                        VStack(alignment: .leading, spacing: 8) {
                            Text("MATCH GAME")
                                .foregroundStyle(.yellow)
                                .font(.system(size: 20, weight: .semibold, design: .monospaced))
                            
                            HStack {
                                Text("Total Games:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                Spacer()
                                Text("\(statisticsManager.statistics.matchTotalGames)")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                            
                            HStack {
                                Text("Wins:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                Spacer()
                                Text("\(statisticsManager.statistics.matchWins)")
                                    .foregroundStyle(.green)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                            
                            HStack {
                                Text("Losses:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                Spacer()
                                Text("\(statisticsManager.statistics.matchLosses)")
                                    .foregroundStyle(.red)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    
                    //MARK: - Reset Statistics Button
                    Button {
                        showResetAlert = true
                    } label: {
                        MainButtonView(title: "RESET STATISTICS")
                    }
                    
                    //MARK: - Terms button
                    Button {
                        if let url = URL(string: terms) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        MainButtonView(title: "TERMS OF USE")
                    }
                    
                    //MARK: - Policy button
                    Button {
                        if let url = URL(string: privacy) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        MainButtonView(title: "PRIVACY POLICY")
                    }
                    
                    //MARK: - rate button
                    Button {
                        SKStoreReviewController.requestReview()
                    } label: {
                        MainButtonView(title: "RATE US")
                    }
                }
                .padding()
            }
        }
        .alert("Reset Statistics", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                statisticsManager.resetAllStatistics()
            }
        } message: {
            Text("Are you sure you want to reset all game statistics? This action cannot be undone.")
        }
    }
}

#Preview {
    SettingsView()
}
