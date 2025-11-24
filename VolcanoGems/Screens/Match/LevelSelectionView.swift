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
                    Image(difficulty.difficultyLabe)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 90)
                    Spacer()
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .bold))
                        .padding()
                        .opacity(0)
                    
                }
                
                
                
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
                                Image(.backCountAnswer)
                                    .resizable()
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
                            .cornerRadius(20)
                        }
                        .disabled(!unlockedLevels.contains(level))
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            unlockedLevels = progressManager.getUnlockedLevels(for: difficulty)
        }
    }
}


