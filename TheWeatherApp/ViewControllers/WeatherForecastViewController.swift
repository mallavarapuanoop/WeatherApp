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
        weatherForecastManager.foreCast?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let main = weatherForecastManager.foreCast?.list?[indexPath.row].main,
              let weather = weatherForecastManager.foreCast?.list?[indexPath.row].weather,
              let climate = weather.first?.main else {
            return UITableViewCell ()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = "\(climate)"
        
        cell.detailTextLabel?.text = "Temp: \(main.temp ?? 0)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let main = weatherForecastManager.foreCast?.list?[indexPath.row].main,
              let weather = weatherForecastManager.foreCast?.list?[indexPath.row].weather else {
            return
        }
        let forecastDetailsController = ForecastDetailsViewController.createViewController()
        forecastDetailsController.main = main
        forecastDetailsController.weather = weather.first
        self.navigationController?.pushViewController(forecastDetailsController, animated: true)
    }
}

extension WeatherForecastViewController: WeatherForecastManagerDelegate {
    func finishedLoading() {
        tableView.reloadData()
    }
}
