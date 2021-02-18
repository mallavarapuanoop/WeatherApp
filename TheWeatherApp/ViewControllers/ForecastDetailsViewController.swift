//
//  ForecastDetailsViewController.swift
//  TheWeatherApp
//
//  Created by Anoop Mallavarapu on 2/17/21.
//

import UIKit

class ForecastDetailsViewController: UIViewController {
    
    var forecast: Forecast?
    
    private var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var climateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var climateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        constructViews()
        constraintViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let forecast = forecast,
              let temperature = forecast.temperature,
              let feelsLike = forecast.feelsLike else { return }
        
        temperatureLabel.text = "\(temperature)"
        feelsLikeLabel.text = "Feels like: \(feelsLike)"
        
        climateLabel.text = forecast.climate
        climateDescriptionLabel.text = forecast.climateDescription
    }
    
    static func createViewController() -> ForecastDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "ForecastDetailsViewController") as! ForecastDetailsViewController
    }
    
    
    private func constructViews() {
        detailsStackView.addArrangedSubview(temperatureLabel)
        detailsStackView.addArrangedSubview(feelsLikeLabel)
        
        detailsStackView.setCustomSpacing(80, after: feelsLikeLabel)
        
        detailsStackView.addArrangedSubview(climateLabel)
        detailsStackView.addArrangedSubview(climateDescriptionLabel)
        self.view.addSubview(detailsStackView)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 40),
            detailsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 16),
            detailsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -16),
            detailsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

