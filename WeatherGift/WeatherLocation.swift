//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Richard Jove on 10/28/19.
//  Copyright © 2019 Richard Jove. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
        
    }
}
