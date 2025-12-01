//
//  Achievement.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation
import Combine

struct Achievement: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let icon: String
    var isUnlocked: Bool
    let requirement: Int
    var currentProgress: Int
    
    var progressPercentage: Double {
        guard requirement > 0 else { return 1.0 }
        return min(Double(currentProgress) / Double(requirement), 1.0)
    }
    
    static let allAchievements: [Achievement] = [
        Achievement(
            id: "first_quiz",
            title: "First Steps",
            description: "Complete your first quiz",
            icon: "🎯",
            isUnlocked: false,
            requirement: 1,
            currentProgress: 0
        ),
        Achievement(
            id: "quiz_master",
            title: "Quiz Master",
            description: "Win 10 quizzes",
            icon: "🏆",
            isUnlocked: false,
            requirement: 10,
            currentProgress: 0
        ),
        Achievement(
            id: "perfect_score",
            title: "Perfect Score",
            description: "Get 100% correct in a quiz",
            icon: "⭐",
            isUnlocked: false,
            requirement: 1,
            currentProgress: 0
        ),
        Achievement(
            id: "memory_champion",
            title: "Memory Champion",
            description: "Win 10 memory games",
            icon: "🧠",
            isUnlocked: false,
            requirement: 10,
            currentProgress: 0
        ),
        Achievement(
            id: "volcano_explorer",
            title: "Volcano Explorer",
            description: "View all 7 volcanoes in Facts",
            icon: "🌋",
            isUnlocked: false,
            requirement: 7,
            currentProgress: 0
        ),
        Achievement(
            id: "hard_mode",
            title: "Hard Mode Expert",
            description: "Complete 5 hard difficulty quizzes",
            icon: "💪",
            isUnlocked: false,
            requirement: 5,
            currentProgress: 0
        ),
        Achievement(
            id: "dedicated_player",
            title: "Dedicated Player",
            description: "Play 50 games total",
            icon: "🎮",
            isUnlocked: false,
            requirement: 50,
            currentProgress: 0
        ),
        Achievement(
            id: "collection_complete",
            title: "Collection Complete",
            description: "View all volcano details",
            icon: "📚",
            isUnlocked: false,
            requirement: 7,
            currentProgress: 0
        )
    ]
}

class AchievementManager: ObservableObject {
    static let shared = AchievementManager()
    
    @Published var achievements: [Achievement] {
        didSet {
            saveAchievements()
        }
    }
    
    private let userDefaults = UserDefaults.standard
    private let achievementsKey = "achievements"
    
    private init() {
        self.achievements = AchievementManager.loadAchievements()
        // Check if user has already completed quizzes and unlock first_quiz if needed
        checkAndUnlockFirstQuiz()
    }
    
    private func checkAndUnlockFirstQuiz() {
        let statistics = GameStatisticsManager.shared.statistics
        let totalQuizzes = statistics.brainTotalGames
        
        if totalQuizzes > 0 {
            // User has completed at least one quiz
            if let index = achievements.firstIndex(where: { $0.id == "first_quiz" }),
               !achievements[index].isUnlocked {
                updateFirstQuiz()
            }
        }
    }
    
    // MARK: - Achievement Updates
    
    func updateFirstQuiz() {
        updateAchievement(id: "first_quiz", progress: 1)
    }
    
    func updateQuizWins(_ count: Int) {
        updateAchievement(id: "quiz_master", progress: count)
    }
    
    func updatePerfectScore() {
        updateAchievement(id: "perfect_score", progress: 1)
    }
    
    func updateMemoryWins(_ count: Int) {
        updateAchievement(id: "memory_champion", progress: count)
    }
    
    func updateVolcanoesViewed(_ count: Int) {
        updateAchievement(id: "volcano_explorer", progress: count)
        updateAchievement(id: "collection_complete", progress: count)
    }
    
    func updateHardModeQuizzes(_ count: Int) {
        updateAchievement(id: "hard_mode", progress: count)
    }
    
    func updateTotalGames(_ count: Int) {
        updateAchievement(id: "dedicated_player", progress: count)
    }
    
    private func updateAchievement(id: String, progress: Int) {
        if let index = achievements.firstIndex(where: { $0.id == id }) {
            var achievement = achievements[index]
            let wasUnlocked = achievement.isUnlocked
            achievement.currentProgress = progress
            
            // Unlock if requirement is met
            if !wasUnlocked && achievement.currentProgress >= achievement.requirement {
                achievement.isUnlocked = true
            }
            
            // Update the achievement in the array (this will trigger didSet and save)
            achievements[index] = achievement
        }
    }
    
    func getUnlockedCount() -> Int {
        achievements.filter { $0.isUnlocked }.count
    }
    
    func getTotalCount() -> Int {
        achievements.count
    }
    
    // MARK: - Persistence
    
    private func saveAchievements() {
        if let encoded = try? JSONEncoder().encode(achievements) {
            userDefaults.set(encoded, forKey: achievementsKey)
        }
    }
    
    private static func loadAchievements() -> [Achievement] {
        let key = "achievements"
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Achievement].self, from: data) else {
            return Achievement.allAchievements
        }
        return decoded
    }
    
    func resetAchievements() {
        achievements = Achievement.allAchievements
    }
}

