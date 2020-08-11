//
//  Name.swift
//  CAnimation
//
//  Created by Sergey Titov on 8/11/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//

import Foundation

struct Cities {
    
      private static let cities = ["Berlin", "Brest", "Washington", "Venice", "Hamburg", "Geneva", "London", "Dublin", "Kiev", "Minsk", "Osaka", "Osaka", "Cologne", "Zurich", "Vilnius", "Duesseldorf"]

    
    static func getRandomName() -> String {
        return cities[Int.random(in: 0..<cities.count)]
    }
}
