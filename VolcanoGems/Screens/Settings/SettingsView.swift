//
//  SettingsView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @State private var terms = "https://www.termsfeed.com/live/c0fef907-0ef7-417d-993e-c442a052b522"
    @State private var privacy = "https://www.termsfeed.com/live/d41592d6-22fc-4001-a733-4b8d9a9b9f1d"
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("SETTINGS")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                
                Spacer()
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
Spacer()
            }.padding()
                
        }
    }
}

#Preview {
    SettingsView()
}
