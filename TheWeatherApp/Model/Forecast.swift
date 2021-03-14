//
//  Forecast.swift
//  TheWeatherApp
//
//  Created by Anoop Mallavarapu on 2/17/21.
//

import Foundation

class Forecast: Codable {
    let list: [List]?
}

class List: Codable {
    let main: Main?
    let weather: [Weather]?
}

class Main: Codable {
    let temp: Double?
    let feels_like: Double?
}

class Weather: Codable {
    let main: String?
    let description: String?
}
