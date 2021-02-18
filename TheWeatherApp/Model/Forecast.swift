//
//  Forecast.swift
//  TheWeatherApp
//
//  Created by Anoop Mallavarapu on 2/17/21.
//

import Foundation

class Forecast {
    var climate: String?
    var temperature: Double?
    var feelsLike: Double?
    var climateDescription: String?
    
    init(climate: String? = nil, temperature: Double? = nil, feelsLike: Double? = nil, climateDescription: String? = nil) {
        self.climate = climate
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.climateDescription = climateDescription
    }
}
