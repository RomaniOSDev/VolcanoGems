//
//  MemoryGameView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

enum CardContent: Equatable {
    case vulcan(Vulcans)
    case card(MemoryCardType)
}

struct MemoryCard: Identifiable {
    let id: UUID = UUID()
    let content: CardContent
    var isFlipped: Bool = false
    var isMatched: Bool = false
    
    var image: ImageResource {
        switch content {
        case .vulcan(let vulcan):
            return vulcan.firstImage
        case .card(let cardType):
            return cardType.image
        }
    }
}

struct MemoryGameView: View {
    let difficulty: MemoryDifficulty
    let level: Int
    let onGameComplete: (Bool) -> Void
    let onBack: () -> Void
    
    @State private var cards: [MemoryCard] = []
    @State private var flippedCardIndices: [Int] = []
    @State private var timeRemaining: Int
    @State private var timer: Timer?
    @State private var matchedPairs = 0
    @State private var gameWon = false
    @State private var gameLost = false
    
    init(difficulty: MemoryDifficulty, level: Int, onGameComplete: @escaping (Bool) -> Void, onBack: @escaping () -> Void) {
        self.difficulty = difficulty
        self.level = level
        self.onGameComplete = onGameComplete
        self.onBack = onBack
        _timeRemaining = State(initialValue: difficulty.timeForLevel(level))
    }
    
    var totalPairs: Int {
        difficulty.totalPairs
    }
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button {
                        timer?.invalidate()
                        onBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold))
                            .padding()
                    }
                    
                    Spacer()
    
                    
                    // Matched pairs
                    Text("\(matchedPairs)/\(totalPairs)")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold, design: .monospaced))
                        .padding()
                }
                .padding(.horizontal)
                
                Spacer()
                // Game grid
                let gridSize = difficulty.gridSize
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: gridSize.columns), spacing: 10) {
                    ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                        CardView(card: card)
                            .onTapGesture {
                                if !card.isFlipped && !card.isMatched && flippedCardIndices.count < 2 && !gameWon && !gameLost {
                                    flipCard(at: index)
                                }
                            }
                    }
                }
                .padding()
                
                Spacer()
                // Timer
                ZStack {
                    Image(.backforanswer)
                        .resizable()
                    Text("\(timeRemaining)s")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .bold, design: .monospaced))
                        .padding()
                }
                .frame(width: 135, height: 70)
                .cornerRadius(20)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            setupGame()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .alert("You Won!", isPresented: $gameWon) {
            Button("Continue") {
                timer?.invalidate()
                onGameComplete(true)
            }
        } message: {
            Text("Congratulations! You found all pairs!")
        }
        .alert("Time's Up!", isPresented: $gameLost) {
            Button("Try Again") {
                timer?.invalidate()
                onGameComplete(false)
            }
        } message: {
            Text("You ran out of time. Try again!")
        }
    }
    
    private func setupGame() {
        let pairsNeeded = totalPairs
        
        // Создаем пары карточек - используем card1-card8 для всех уровней
        var newCards: [MemoryCard] = []
        
        // Используем карточки card1-card8
        let cardsToUse = Array(MemoryCardType.allCases.prefix(pairsNeeded))
        for cardType in cardsToUse {
            newCards.append(MemoryCard(content: .card(cardType)))
            newCards.append(MemoryCard(content: .card(cardType)))
        }
        
        // Перемешиваем
        newCards.shuffle()
        
        // Для среднего уровня (3x3 = 9 ячеек) нужно 4 пары = 8 карточек
        if difficulty == .medium && newCards.count > 8 {
            newCards = Array(newCards.prefix(8))
        }
        
        cards = newCards
    }
    
    private func flipCard(at index: Int) {
        cards[index].isFlipped = true
        flippedCardIndices.append(index)
        
        if flippedCardIndices.count == 2 {
            checkMatch()
        }
    }
    
    private func checkMatch() {
        let firstIndex = flippedCardIndices[0]
        let secondIndex = flippedCardIndices[1]
        
        if cards[firstIndex].content == cards[secondIndex].content {
            // Match found
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            matchedPairs += 1
            
            flippedCardIndices.removeAll()
            
            // Check if all pairs are matched
            if matchedPairs == totalPairs {
                gameWon = true
                timer?.invalidate()
            }
        } else {
            // No match - flip back after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                cards[firstIndex].isFlipped = false
                cards[secondIndex].isFlipped = false
                flippedCardIndices.removeAll()
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                gameLost = true
            }
        }
    }
}

struct CardView: View {
    let card: MemoryCard
    
    var body: some View {
        ZStack {
            Image(.backCountAnswer)
                .resizable()
                .cornerRadius(20)
            
            if card.isFlipped || card.isMatched {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
            } else {
               
                        Image(systemName: "questionmark")
                            .foregroundStyle(.white.opacity(0.7))
                            .font(.system(size: 40, weight: .bold))
                    
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: card.isFlipped)
    }
}

