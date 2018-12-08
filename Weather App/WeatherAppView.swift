//
//  WeatherAppView.swift
//  WatherApp
//
//  Created by Arturs Vitins on 08/12/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

class WeatherAppView: UIView {
    
    #error("To use this app please add your custom apiKey from openweathermap.org in - let apiKey")
    private let apiKey = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        WeatherAppFunctions.delegate = self
    }
    
    func setupView() {
        
        self.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        self.addSubview(mainTextField)
        NSLayoutConstraint.activate([
            mainTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            mainTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        self.addSubview(mainButton)
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: mainTextField.bottomAnchor, constant: 20),
            mainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        self.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    let mainLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 40)
        lbl.textAlignment = .center
        lbl.textColor = .orange
        lbl.text = "Weather app"
        return lbl
    }()
    
    let mainTextField: UITextField = {
        let txtField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "...san francisco, london, paris ..."
        txtField.font = UIFont.systemFont(ofSize: 15)
        txtField.borderStyle = UITextField.BorderStyle.roundedRect
        txtField.autocorrectionType = UITextAutocorrectionType.no
        txtField.keyboardType = UIKeyboardType.default
        txtField.returnKeyType = UIReturnKeyType.done
        txtField.clearButtonMode = UITextField.ViewMode.whileEditing
        txtField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return txtField
    }()
    
    let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        return button
    }()
    
    let infoLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textAlignment = .center
        lbl.textColor = .orange
        lbl.numberOfLines = 0
        lbl.text = ""
        return lbl
    }()
    
    
    @objc private func okTapped() {
        if let text = mainTextField.text {
            let country = text.replacingOccurrences(of: " ", with: "%20")
            WeatherAppFunctions.getAllData(country: country, apiKey: apiKey)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherAppView: WeatherDataInfoDelegate {
    func newInfo(minTemp: String, maxTemp: String) {
        infoLabel.text = "Min temp = \(minTemp) \n Max temp = \(maxTemp)"
    }
    
    func catchedError() {
        infoLabel.text = "Can't find this city"
    }
}
