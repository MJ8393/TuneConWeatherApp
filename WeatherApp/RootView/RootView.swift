//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation

protocol RootView {
    func setRootView()
    
    func configureUI()
    func addSubviews()
    func setConstraints()
    func setupBinding()
}

extension RootView {
    func setRootView() {
        configureUI()
        addSubviews()
        setConstraints()
        setupBinding()
    }
    
    func setupBinding() { }
}
