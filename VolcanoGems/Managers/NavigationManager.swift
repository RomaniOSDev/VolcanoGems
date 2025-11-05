//
//  NavigationManager.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Combine
import SwiftUI
import Foundation

final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to screen: AppRoute) {
        path.append(screen)
    }
    
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}



