//
//  Vulcans.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

enum Vulcans: CaseIterable{
    case vesuvi, fuji, krakata, heles, etha, yellow, loa
    
    var firstImage: ImageResource {
        switch self {
            
        case .vesuvi:
            return .visuvi1
        case .fuji:
            return .fiju
        case .krakata:
            return .krakata1
        case .heles:
            return .helens1
        case .etha:
            return .etha1
        case .yellow:
            return .yellow
        case .loa:
            return .loa1
        }
    }
    
    var nextImage: ImageResource {
        switch self {
            
        case .vesuvi:
            return .visuvi2
        case .fuji:
            return .fiju2
        case .krakata:
            return .krakata2
        case .heles:
            return .helens2
        case .etha:
            return .etha2
        case .yellow:
            return .yellow2
        case .loa:
            return .loa2
        }
    }
}
