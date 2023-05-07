//
//  MarsWeatherViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 04.02.2023.
//

import UIKit

final class MarsWeatherViewController: UIViewController {
    
    private var presenter: MarsWeatherPresenter?
    
    private let WeatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Марс Погода"
        view.addSubview(WeatherLabel)
        SetUpConstraints()
        presenter?.SetViewDelegate(delegate: self)
        presenter?.GetMarsWeather()
    }
    
    init(presenter: MarsWeatherPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            WeatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            WeatherLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            WeatherLabel.widthAnchor.constraint(equalToConstant: 200),
            WeatherLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension MarsWeatherViewController: MarsWeatherPresenterDelegate {
    
    func displayMarsWeather(weather: ValidityChecks) {
        WeatherLabel.text = "Sol Hours Required: \(weather.solHoursRequired)"
    }
}
