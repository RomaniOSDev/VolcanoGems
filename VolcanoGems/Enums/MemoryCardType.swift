//
//  MemoryCardType.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

enum MemoryCardType: CaseIterable {
    case card1, card2, card3, card4, card5, card6, card7, card8
    
    var image: ImageResource {
        switch self {
        case .card1:
            return .card1
        case .card2:
            return .card2
        case .card3:
            return .card3
        case .card4:
            return .card4
        case .card5:
            return .card5
        case .card6:
            return .card6
        case .card7:
            return .card7
        case .card8:
            return .card8
        }
    }
}



