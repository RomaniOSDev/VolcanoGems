//
//  QuizQuestion.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation

struct QuizQuestion: Identifiable {
    let id: Int
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    
    var correctAnswer: String {
        options[correctAnswerIndex]
    }
}

class QuizData {
    static let shared = QuizData()
    
    private init() {}
    
    let allQuestions: [QuizQuestion] = [
        // Easy (1-10)
        QuizQuestion(id: 1, question: "Volcano that destroyed Pompeii:", options: ["Etna", "Vesuvius", "Stromboli"], correctAnswerIndex: 1),
        QuizQuestion(id: 2, question: "Where is Mount Fuji?", options: ["China", "Japan", "Korea"], correctAnswerIndex: 1),
        QuizQuestion(id: 3, question: "What flows from a volcano?", options: ["Water", "Rocks", "Lava"], correctAnswerIndex: 2),
        QuizQuestion(id: 4, question: "What do we call a sleeping volcano?", options: ["Dormant", "Old", "Calm"], correctAnswerIndex: 0),
        QuizQuestion(id: 5, question: "Volcano in Hawaii:", options: ["Mauna Loa", "Eyjafjallajökull", "Etna"], correctAnswerIndex: 0),
        QuizQuestion(id: 6, question: "Who studies volcanoes?", options: ["Geologist", "Volcanologist", "Astrologer"], correctAnswerIndex: 1),
        QuizQuestion(id: 7, question: "Volcano on Sicily:", options: ["Etna", "Vesuvius", "Tambora"], correctAnswerIndex: 0),
        QuizQuestion(id: 8, question: "What forms from lava?", options: ["Rock", "Dust", "Snow"], correctAnswerIndex: 0),
        QuizQuestion(id: 9, question: "Volcano in Africa:", options: ["Kilimanjaro", "Mauna Kea", "Fuji"], correctAnswerIndex: 0),
        QuizQuestion(id: 10, question: "Where is Hekla volcano?", options: ["Iceland", "Japan", "Mexico"], correctAnswerIndex: 0),
        
        // Medium (11-20)
        QuizQuestion(id: 11, question: "What does a volcano throw out?", options: ["Sand", "Ash", "Rain"], correctAnswerIndex: 1),
        QuizQuestion(id: 12, question: "The most active volcano on Earth:", options: ["Kīlauea", "Tambora", "Etna"], correctAnswerIndex: 0),
        QuizQuestion(id: 13, question: "Volcano on Java Island:", options: ["Krakatoa", "Popocatépetl", "Villarrica"], correctAnswerIndex: 0),
        QuizQuestion(id: 14, question: "Country of Eyjafjallajökull:", options: ["Norway", "Iceland", "Finland"], correctAnswerIndex: 1),
        QuizQuestion(id: 15, question: "Continent of Kilimanjaro:", options: ["Asia", "Africa", "Australia"], correctAnswerIndex: 1),
        QuizQuestion(id: 16, question: "Highest volcano (underwater):", options: ["Mauna Kea", "Everest", "Etna"], correctAnswerIndex: 0),
        QuizQuestion(id: 17, question: "When did Vesuvius destroy Pompeii?", options: ["79 AD", "800 AD", "1500 AD"], correctAnswerIndex: 0),
        QuizQuestion(id: 18, question: "What remains after an eruption?", options: ["Ash", "Snow", "Water"], correctAnswerIndex: 0),
        QuizQuestion(id: 19, question: "What's inside a volcano?", options: ["Lava", "Ice", "Air"], correctAnswerIndex: 0),
        QuizQuestion(id: 20, question: "What causes an eruption?", options: ["Magma", "Wind", "Sun"], correctAnswerIndex: 0),
        
        // Hard (21-30)
        QuizQuestion(id: 21, question: "Where is Popocatépetl?", options: ["Peru", "Mexico", "India"], correctAnswerIndex: 1),
        QuizQuestion(id: 22, question: "Supervolcano in the USA:", options: ["Yellowstone", "Tambora", "Etna"], correctAnswerIndex: 0),
        QuizQuestion(id: 23, question: "The largest volcano in the Solar System:", options: ["Olympus Mons", "Fuji", "Etna"], correctAnswerIndex: 0),
        QuizQuestion(id: 24, question: "Planet with Olympus Mons:", options: ["Mars", "Venus", "Earth"], correctAnswerIndex: 0),
        QuizQuestion(id: 25, question: "Krakatoa eruption year:", options: ["1883", "1950", "2001"], correctAnswerIndex: 0),
        QuizQuestion(id: 26, question: "Volcano in Kamchatka:", options: ["Klyuchevskaya Sopka", "Elbrus", "Kazbek"], correctAnswerIndex: 0),
        QuizQuestion(id: 27, question: "Highest volcano in South America:", options: ["Ojos del Salado", "Cotopaxi", "Villarrica"], correctAnswerIndex: 0),
        QuizQuestion(id: 28, question: "Island made of volcanoes:", options: ["Iceland", "Cuba", "Madagascar"], correctAnswerIndex: 0),
        QuizQuestion(id: 29, question: "Volcano under the sea is called:", options: ["Underwater", "Deep", "Quiet"], correctAnswerIndex: 0),
        QuizQuestion(id: 30, question: "What can form after an eruption?", options: ["New island", "Tornado", "Comet"], correctAnswerIndex: 0)
    ]
    
    func questions(for difficulty: DifficultyLevel) -> [QuizQuestion] {
        let range = difficulty.questionRange
        return allQuestions.filter { range.contains($0.id) }
    }
}



