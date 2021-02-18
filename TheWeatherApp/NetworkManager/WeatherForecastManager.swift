//
//  WeatherForecastManager.swift
//  TheWeatherApp
//
//  Created by Anoop Mallavarapu on 2/17/21.
//

import Foundation

protocol WeatherForecastManagerDelegate: class {
    func finishedLoading()
}

class WeatherForecastManager {
    
    var forecastArray = [Forecast]()
    
    weak var delegate: WeatherForecastManagerDelegate?
    
    func fetchWeatherForecast(city: String, delegate: WeatherForecastManagerDelegate) {
        self.delegate = delegate
        let api = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=65d00499677e59496ca2f318eb68c049"
        let url = URL(string: api)
        
        do{
            guard let url = url else { return }
            let response = try Data.init(contentsOf: url)
            let parsedResponse = try JSONSerialization.jsonObject(with: response, options: []) as! [String: Any]
            guard let list = parsedResponse["list"] as? [[String:Any]] else { return }
            
            for values in list {
                guard let main = values["main"] as? [String: Any] else { return }
                
                guard let temperature = main["temp"] as? Double else { return}
                
                guard let feelsLike = main["feels_like"] as? Double else { return }
                
                guard let weather = values["weather"] as? [[String:Any]] else { return }
                
                let forecast = Forecast(temperature: temperature, feelsLike: feelsLike)
                
                for report in weather {
                    guard let climate = report["main"] as? String else { return }
                    
                    guard let climateDescription = report["description"] as? String else { return }
                    
                    forecast.climate = climate
                    forecast.climateDescription = climateDescription
                    
                    forecastArray.append(forecast)
                }
            }
            
            if let delegate = self.delegate {
                delegate.finishedLoading()
            }
            
        } catch let error {
            print(error)
            
        }
        
    }
}
