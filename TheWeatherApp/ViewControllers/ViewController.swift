//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Anoop Mallavarapu on 2/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter City name"
        textField.adjustsFontForContentSizeCategory = true
        textField.textColor = UIColor.label
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var lookUpButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Lookup",
                                                     attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBlue,
                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]),
                                  for: .normal)
        
        button.addTarget(self, action: #selector(lookUpForecast), for: .touchUpInside)
        button.titleLabel?.textColor = .blue
        button.backgroundColor = UIColor.systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    @objc
    func lookUpForecast() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        let forecastController = WeatherForecastViewController.createViewController()
        forecastController.city = text
        self.navigationController?.pushViewController(forecastController, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        constructViews()
        constraintViews()
    }
    
    private func constructViews() {
        detailsStackView.addArrangedSubview(textField)
        detailsStackView.addArrangedSubview(separator)
        detailsStackView.setCustomSpacing(10, after: separator)
        detailsStackView.addArrangedSubview(lookUpButton)
        
        containerView.addSubview(detailsStackView)
        
        view.addSubview(containerView)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            detailsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            detailsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            lookUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.7)
        ])
    }
}
