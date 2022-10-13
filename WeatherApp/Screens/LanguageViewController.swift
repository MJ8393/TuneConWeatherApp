//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import UIKit

protocol LanguageViewControllerDelegate: AnyObject {
    func languageChanged(tag: Int)
}

class LanguageViewController: UIViewController {
    
    // MARK: Properties
    weak var delegate: LanguageViewControllerDelegate?
    
    // MARK: Outlets
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.text = "changeLanguage".translate()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var englishButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("English", for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .systemGreen
        btn.addTarget(self, action: #selector(didTapButtons), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    lazy var russianButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Русский", for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .systemGreen
        btn.addTarget(self, action: #selector(didTapButtons), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    // MARK: ViewController Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setRootView()
    }
    
    // MARK: Actions
    @objc func didTapButtons(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            LanguageManager.setApplLang(Language.Russian)
        case 1:
            LanguageManager.setApplLang(Language.English)
        default:
            break
        }
        delegate?.languageChanged(tag: sender.tag)
        dismiss(animated: true)
    }

   
    
}

// MARK: - Extension RootView
extension LanguageViewController: RootView {
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func addSubviews() {
        view.addSubview(languageLabel)
        view.addSubview(stackView)
        for button in [englishButton, russianButton] {
            stackView.addArrangedSubview(button)
        }
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalTo(view)
            make.height.equalTo(200)
        }
        
        for button in [englishButton, russianButton] {
            button.snp.makeConstraints { make in
                make.width.equalTo(300)
            }
        }
        
        languageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(stackView.snp.top).offset(-20)
            make.height.equalTo(40)
        }
    }
    
}
