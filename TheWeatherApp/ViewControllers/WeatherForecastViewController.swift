//
//  WeatherForecastViewController.swift
//  TheWeatherApp
//
//  Created by Anoop Mallavarapu on 2/17/21.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .blue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    private let weatherForecastManager = WeatherForecastManager()
    
    var city: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = city
        fetchWeatherForecast(for: city)
    }
    
    static func createViewController() -> WeatherForecastViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
    }
    
    func fetchWeatherForecast(for city: String?) {
        guard let city = city else { return }
        weatherForecastManager.fetchWeatherForecast(city: city, delegate: self)
    }
}

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherForecastManager.forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        let forecast = weatherForecastManager.forecastArray[indexPath.row]
        
        cell.textLabel?.text = forecast.climate
        
        cell.detailTextLabel?.text = "Temp: \(forecast.temperature ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let forecastDetailsController = ForecastDetailsViewController.createViewController()
        forecastDetailsController.forecast = weatherForecastManager.forecastArray[indexPath.row]
        self.navigationController?.pushViewController(forecastDetailsController, animated: true)
    }
}

extension WeatherForecastViewController: WeatherForecastManagerDelegate {
    func finishedLoading() {
        tableView.reloadData()
    }
}
