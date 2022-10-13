//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import UIKit

class LoadingView: UIView {
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Loading..."
        label.textAlignment = .center
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .systemGray2
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(activityIndicator)
        self.addSubview(loadingLabel)
    }

    private func makeConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
        
        loadingLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(activityIndicator.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
    }
    
}
