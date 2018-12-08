//
//  ViewController.swift
//  WatherApp
//
//  Created by Arturs Vitins on 04/12/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

class WatherAppViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(weatherView)
        weatherView.attachZeroAnchors(to: self.view)
    }
    
    let weatherView: WeatherAppView = {
        let currView = WeatherAppView()
        currView.translatesAutoresizingMaskIntoConstraints = false
        currView.backgroundColor = .black
        return currView
    }()
    
}

