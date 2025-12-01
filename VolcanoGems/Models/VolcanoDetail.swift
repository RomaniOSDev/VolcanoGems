//
//  VolcanoDetail.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation

struct VolcanoDetail: Identifiable {
    let id: String
    let vulcan: Vulcans
    let name: String
    let location: String
    let height: String
    let lastEruption: String
    let description: String
    let interestingFacts: [String]
    let type: String
    
    static let allDetails: [VolcanoDetail] = [
        VolcanoDetail(
            id: "vesuvi",
            vulcan: .vesuvi,
            name: "Mount Vesuvius",
            location: "Italy, Campania",
            height: "1,281 m",
            lastEruption: "1944",
            description: "Mount Vesuvius is a somma-stratovolcano located on the Gulf of Naples in Campania, Italy. It is one of the most dangerous volcanoes in the world due to its proximity to the densely populated city of Naples.",
            interestingFacts: [
                "Destroyed the ancient Roman cities of Pompeii and Herculaneum in 79 AD",
                "The only active volcano on mainland Europe",
                "Over 3 million people live in its danger zone",
                "Last erupted in 1944 during World War II"
            ],
            type: "Stratovolcano"
        ),
        VolcanoDetail(
            id: "fuji",
            vulcan: .fuji,
            name: "Mount Fuji",
            location: "Japan, Honshu",
            height: "3,776 m",
            lastEruption: "1707-1708",
            description: "Mount Fuji is an active stratovolcano and the highest peak in Japan. It is one of Japan's 'Three Holy Mountains' and is considered a sacred symbol of Japan.",
            interestingFacts: [
                "Last erupted in 1707-1708",
                "A UNESCO World Heritage Site since 2013",
                "Climbed by over 300,000 people annually",
                "Appears in countless works of Japanese art"
            ],
            type: "Stratovolcano"
        ),
        VolcanoDetail(
            id: "krakata",
            vulcan: .krakata,
            name: "Krakatoa",
            location: "Indonesia, Sunda Strait",
            height: "813 m",
            lastEruption: "2022",
            description: "Krakatoa is a volcanic island in the Sunda Strait between Java and Sumatra. The 1883 eruption was one of the most violent volcanic events in recorded history.",
            interestingFacts: [
                "1883 eruption was heard 3,000 miles away",
                "Created a tsunami that killed over 36,000 people",
                "The sound was the loudest ever recorded",
                "Formed a new island called Anak Krakatau (Child of Krakatoa)"
            ],
            type: "Caldera"
        ),
        VolcanoDetail(
            id: "heles",
            vulcan: .heles,
            name: "Mount St. Helens",
            location: "USA, Washington",
            height: "2,549 m",
            lastEruption: "2008",
            description: "Mount St. Helens is an active stratovolcano in Skamania County, Washington. The 1980 eruption was the deadliest and most economically destructive volcanic event in U.S. history.",
            interestingFacts: [
                "1980 eruption reduced its height by 400 meters",
                "Killed 57 people and destroyed 200 homes",
                "Created the largest landslide in recorded history",
                "Still actively monitored by volcanologists"
            ],
            type: "Stratovolcano"
        ),
        VolcanoDetail(
            id: "etha",
            vulcan: .etha,
            name: "Mount Etna",
            location: "Italy, Sicily",
            height: "3,357 m",
            lastEruption: "2023",
            description: "Mount Etna is an active stratovolcano on the east coast of Sicily, Italy. It is one of the most active volcanoes in the world and the tallest active volcano in Europe.",
            interestingFacts: [
                "Most active volcano in Europe",
                "Erupts almost continuously",
                "A UNESCO World Heritage Site",
                "Has been erupting for over 500,000 years"
            ],
            type: "Stratovolcano"
        ),
        VolcanoDetail(
            id: "yellow",
            vulcan: .yellow,
            name: "Yellowstone Caldera",
            location: "USA, Wyoming",
            height: "2,805 m",
            lastEruption: "640,000 years ago",
            description: "Yellowstone Caldera is a volcanic caldera and supervolcano in Yellowstone National Park. It is one of the largest active volcanic systems in the world.",
            interestingFacts: [
                "Supervolcano that could affect global climate",
                "Last major eruption was 640,000 years ago",
                "Home to over 10,000 geothermal features",
                "Monitored 24/7 by the USGS"
            ],
            type: "Supervolcano"
        ),
        VolcanoDetail(
            id: "loa",
            vulcan: .loa,
            name: "Mauna Loa",
            location: "USA, Hawaii",
            height: "4,169 m",
            lastEruption: "2022",
            description: "Mauna Loa is one of five volcanoes that form the Island of Hawaii. It is the largest active volcano on Earth in terms of volume and area covered.",
            interestingFacts: [
                "Largest volcano on Earth by volume",
                "Covers half of the Big Island of Hawaii",
                "Rises 9 km from the ocean floor",
                "Last erupted in November 2022"
            ],
            type: "Shield Volcano"
        )
    ]
    
    static func detail(for vulcan: Vulcans) -> VolcanoDetail? {
        return allDetails.first { $0.vulcan == vulcan }
    }
}

