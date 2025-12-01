//
//  FactsView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct FactsView: View {
    @StateObject private var achievementManager = AchievementManager.shared
    @State private var flippedCards: Set<Vulcans> = []
    @State private var viewedVolcanoes: Set<Vulcans> = []
    
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("VOLCANO FACTS")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                TabView {
                    ForEach(Vulcans.allCases, id: \.self) { vulcan in
                        VolcanoCard(vulcan: vulcan, isFlipped: flippedCards.contains(vulcan)) {
                            if flippedCards.contains(vulcan) {
                                flippedCards.remove(vulcan)
                            } else {
                                flippedCards.insert(vulcan)
                                if !viewedVolcanoes.contains(vulcan) {
                                    viewedVolcanoes.insert(vulcan)
                                    achievementManager.updateVolcanoesViewed(viewedVolcanoes.count)
                                }
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                
                Spacer()
                
            }.padding()
        }
    }
}

struct VolcanoCard: View {
    let vulcan: Vulcans
    let isFlipped: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            // Передняя сторона
            Image(vulcan.firstImage)
                .resizable()
                .scaleEffect(1.5)
                .aspectRatio(contentMode: .fit)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, 0)
                )
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isFlipped)
            
            // Обратная сторона (зеркально отраженная)
            Image(vulcan.nextImage)
                .resizable()
                .scaleEffect(1.5)
                .aspectRatio(contentMode: .fit)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -180),
                    axis: (x: 0, y: 1, 0)
                )
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isFlipped)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                onTap()
            }
        }
    }
}

#Preview {
    FactsView()
}
