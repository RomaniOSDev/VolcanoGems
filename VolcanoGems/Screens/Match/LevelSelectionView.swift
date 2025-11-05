//
//  LevelSelectionView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct LevelSelectionView: View {
    let difficulty: MemoryDifficulty
    let onLevelSelected: (Int) -> Void
    let onBack: () -> Void
    
    @StateObject private var progressManager = MemoryProgressManager.shared
    @State private var unlockedLevels: Set<Int> = []
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Button {
                        onBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold))
                            .padding()
                    }
                    
                    Spacer()
                }
                
                Text("SELECT LEVEL")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Level grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                    ForEach(1...6, id: \.self) { level in
                        Button {
                            if unlockedLevels.contains(level) {
                                onLevelSelected(level)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(unlockedLevels.contains(level) ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
                                
                                VStack {
                                    if unlockedLevels.contains(level) {
                                        Text("\(level)")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                                        
                                        Text("\(difficulty.timeForLevel(level))s")
                                            .foregroundStyle(.white.opacity(0.8))
                                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                                    } else {
                                        Image(systemName: "lock.fill")
                                            .foregroundStyle(.white.opacity(0.5))
                                            .font(.system(size: 30))
                                    }
                                }
                            }
                            .frame(width: 100, height: 100)
                        }
                        .disabled(!unlockedLevels.contains(level))
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            unlockedLevels = progressManager.getUnlockedLevels(for: difficulty)
        }
    }
}

