//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    static let identifier = "cellID"
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
    }
    
    private func addSubviews() {
        self.addSubview(containerView)
        self.addSubview(stackView)
        for label in [temperatureLabel, descriptionLabel, locationLabel] {
            stackView.addArrangedSubview(label)
        }
        self.addSubview(weatherImageView)
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.equalTo(weatherImageView.snp.leading)
            make.top.leading.equalTo(containerView).offset(20)
            make.bottom.equalTo(containerView).offset(-20)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.centerY.equalTo(self)
            make.height.equalTo(100)
        }
        
    }
    
    func setData(model: DailyWeather) {
        temperatureLabel.text = "\(model.temp.day.formatTemp())"
        descriptionLabel.text = model.weather[0].description.capitalized
        locationLabel.text = "\(model.dt.dateFormat(.day))"
        weatherImageView.image = Helper.getConditionImage(weatherId: model.weather[0].id)
    }
    
}
