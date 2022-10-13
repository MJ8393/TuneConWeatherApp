//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import UIKit
import SnapKit
import CoreLocation

class CurrentViewController: UIViewController {
    
    //MARK: Properties
    var viewModel = WeatherViewModel()
    let locationManager = CLLocationManager()
    
    //MARK: Outlets
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var languageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("changeLanguage".translate(), for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .systemGreen
        btn.addTarget(self, action: #selector(languageBtnTapped), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    
    //MARK: ViewController Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setRootView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "currectWeather".translate()
    }
    
    //MARK: Actions
    @objc func listButtonTapped() {
        let vc = DailyViewController()
        if let weatherData = viewModel.weatherData {
            vc.dailyWeather = weatherData.daily
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func mapButtonTapped() {
        let vc = MapViewController()
        if let location = viewModel.location {
            vc.location = location
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func languageBtnTapped() {
        let vc = LanguageViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
}

// MARK: - Extension CLLocationManagerDelegate
extension CurrentViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            viewModel.getWeatherData(location: location, lang: LanguageManager.getAppLang().rawValue)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Extension RootView
extension CurrentViewController: RootView {
    
    func configureUI() {
        view.backgroundColor = UIColor.systemBackground
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(listButtonTapped))
        navigationItem.rightBarButtonItem = listButton
        let locationButton = UIBarButtonItem(image: UIImage(systemName: "mappin.circle.fill"), style: .plain, target: self, action: #selector(mapButtonTapped))
        navigationItem.leftBarButtonItem = locationButton
    }
    
    func addSubviews() {
        view.addSubview(weatherImageView)
        view.addSubview(stackView)
        for label in [temperatureLabel, descriptionLabel] {
            stackView.addArrangedSubview(label)
        }
        view.addSubview(languageButton)
    }
    
    func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(weatherImageView.snp.bottom).offset(20)
            make.height.equalTo(200)
        }
        
        languageButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
    }
    
    func setupBinding(){
        viewModel.weatherDataDidChange = {
            DispatchQueue.main.async {
                guard let weatherData = self.viewModel.weatherData else { return }
                self.weatherImageView.image = Helper.getConditionImage(weatherId: weatherData.current.weather[0].id)
                self.temperatureLabel.text = "\(weatherData.current.temp.formatTemp())"
                self.descriptionLabel.text = weatherData.current.weather[0].description.capitalized
            }
        }
        
        viewModel.loadingDidChange = {
            if let isLoading = self.viewModel.isLoading {
                isLoading ? self.showLoadingView() : self.dissmissLoadingView()
            }
        }
    }
}

extension CurrentViewController: LanguageViewControllerDelegate {
    func languageChanged(tag: Int) {
        if let location = viewModel.location {
            viewModel.getWeatherData(location: location, lang: LanguageManager.getAppLang().rawValue)
        }
        title = "currectWeather".translate()
        languageButton.setTitle("changeLanguage".translate(), for: .normal)
    }
    
}
