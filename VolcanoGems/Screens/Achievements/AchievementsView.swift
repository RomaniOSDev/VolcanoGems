//
//  AchievementsView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct AchievementsView: View {
    @StateObject private var achievementManager = AchievementManager.shared
    @State private var showResetAlert = false
    
    var unlockedCount: Int {
        achievementManager.getUnlockedCount()
    }
    
    var totalCount: Int {
        achievementManager.getTotalCount()
    }
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // Header
                VStack(spacing: 10) {
                    Text("ACHIEVEMENTS")
                        .foregroundStyle(.white)
                        .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    
                    Text("\(unlockedCount) / \(totalCount) Unlocked")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                    
                    // Progress Bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(height: 20)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [.yellow, .orange],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(
                                    width: geometry.size.width * CGFloat(unlockedCount) / CGFloat(totalCount),
                                    height: 20
                                )
                                .cornerRadius(10)
                                .animation(.spring(), value: unlockedCount)
                        }
                    }
                    .frame(height: 20)
                    .padding(.horizontal)
                }
                .padding(.top)
                
                // Achievements List
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(achievementManager.achievements) { achievement in
                            AchievementRow(achievement: achievement)
                        }
                    }
                    .padding()
                }
                
                // Reset Button (optional, for testing)
                #if DEBUG
                Button {
                    showResetAlert = true
                } label: {
                    Text("Reset Achievements")
                        .foregroundStyle(.red)
                        .font(.system(size: 14, design: .monospaced))
                }
                .padding(.bottom)
                #endif
            }
        }
        .alert("Reset Achievements", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                achievementManager.resetAchievements()
            }
        } message: {
            Text("Are you sure you want to reset all achievements? This action cannot be undone.")
        }
    }
}

struct AchievementRow: View {
    let achievement: Achievement
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon
            ZStack {
                Circle()
                    .fill(achievement.isUnlocked ? Color.yellow.opacity(0.3) : Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                
                Text(achievement.icon)
                    .font(.system(size: 30))
                    .opacity(achievement.isUnlocked ? 1.0 : 0.5)
            }
            
            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(achievement.title)
                    .foregroundStyle(achievement.isUnlocked ? .white : .gray)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                
                Text(achievement.description)
                    .foregroundStyle(achievement.isUnlocked ? .white.opacity(0.8) : .gray.opacity(0.6))
                    .font(.system(size: 14, design: .monospaced))
                
                // Progress
                if !achievement.isUnlocked {
                    HStack {
                        Text("Progress: \(achievement.currentProgress) / \(achievement.requirement)")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 12, design: .monospaced))
                        
                        Spacer()
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(height: 6)
                                .cornerRadius(3)
                            
                            Rectangle()
                                .fill(Color.yellow.opacity(0.6))
                                .frame(
                                    width: geometry.size.width * achievement.progressPercentage,
                                    height: 6
                                )
                                .cornerRadius(3)
                        }
                    }
                    .frame(height: 6)
                } else {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .font(.system(size: 16))
                        Text("Unlocked!")
                            .foregroundStyle(.green)
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            achievement.isUnlocked ?
            Color.green.opacity(0.1) :
            Color.black.opacity(0.3)
        )
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    achievement.isUnlocked ? Color.green : Color.clear,
                    lineWidth: 2
                )
        )
    }
}

#Preview {
    AchievementsView()
}

