//
//  CollectionView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct CollectionView: View {
    @StateObject private var achievementManager = AchievementManager.shared
    @State private var selectedVolcano: VolcanoDetail?
    @State private var viewedVolcanoes: Set<String> = []
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("VOLCANO COLLECTION")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        ForEach(VolcanoDetail.allDetails) { detail in
                            VolcanoCollectionCard(
                                detail: detail,
                                isViewed: viewedVolcanoes.contains(detail.id)
                            ) {
                                selectedVolcano = detail
                                if !viewedVolcanoes.contains(detail.id) {
                                    viewedVolcanoes.insert(detail.id)
                                    saveViewedVolcanoes()
                                    achievementManager.updateVolcanoesViewed(viewedVolcanoes.count)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .sheet(item: $selectedVolcano) { detail in
            VolcanoDetailView(detail: detail)
        }
        .onAppear {
            loadViewedVolcanoes()
        }
    }
    
    private func loadViewedVolcanoes() {
        if let data = UserDefaults.standard.data(forKey: "viewed_volcanoes"),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            viewedVolcanoes = decoded
        }
    }
    
    private func saveViewedVolcanoes() {
        if let encoded = try? JSONEncoder().encode(viewedVolcanoes) {
            UserDefaults.standard.set(encoded, forKey: "viewed_volcanoes")
        }
    }
}

struct VolcanoCollectionCard: View {
    let detail: VolcanoDetail
    let isViewed: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 10) {
                Image(detail.vulcan.firstImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .cornerRadius(10)
                
                Text(detail.name)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                if isViewed {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.system(size: 20))
                }
            }
            .padding()
            .background(Color.black.opacity(0.4))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isViewed ? Color.green : Color.clear, lineWidth: 2)
            )
        }
    }
}

struct VolcanoDetailView: View {
    let detail: VolcanoDetail
    @Environment(\.dismiss) var dismiss
    @State private var showFacts = false
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header Image
                    Image(detail.vulcan.firstImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 250)
                        .cornerRadius(15)
                    
                    // Title
                    Text(detail.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .heavy, design: .monospaced))
                    
                    // Basic Info
                    VStack(spacing: 12) {
                        InfoRow(label: "Location", value: detail.location)
                        InfoRow(label: "Height", value: detail.height)
                        InfoRow(label: "Type", value: detail.type)
                        InfoRow(label: "Last Eruption", value: detail.lastEruption)
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    
                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ABOUT")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                        
                        Text(detail.description)
                            .foregroundStyle(.white)
                            .font(.system(size: 16, design: .monospaced))
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    
                    // Interesting Facts
                    VStack(alignment: .leading, spacing: 10) {
                        Text("INTERESTING FACTS")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                        
                        ForEach(Array(detail.interestingFacts.enumerated()), id: \.offset) { index, fact in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(index + 1).")
                                    .foregroundStyle(.yellow)
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                Text(fact)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, design: .monospaced))
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(15)
                    
                    // Close Button
                    Button {
                        dismiss()
                    } label: {
                        MainButtonView(title: "CLOSE")
                    }
                    .padding(.bottom)
                }
                .padding()
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                .foregroundStyle(.yellow)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
            Spacer()
            Text(value)
                .foregroundStyle(.white)
                .font(.system(size: 16, design: .monospaced))
        }
    }
}

#Preview {
    CollectionView()
}

