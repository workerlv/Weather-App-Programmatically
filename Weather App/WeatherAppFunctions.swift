//
//  WeatherAppFunctions.swift
//  WatherApp
//
//  Created by Arturs Vitins on 05/12/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

protocol WeatherDataInfoDelegate {
    func newInfo(minTemp: String, maxTemp: String)
    func catchedError()
}

struct JsonDataStruct: Decodable {
    let main: ItemDataStruct
}

struct ItemDataStruct: Decodable {
    let temp_min: Double?
    let temp_max: Double?
}

struct WeatherAppFunctions {
    
    static var delegate: WeatherDataInfoDelegate?
    
    static func getAllData(country: String, apiKey: String) {
        let urlLink = "https://api.openweathermap.org/data/2.5/weather?q=\(country)&appid=\(apiKey)"
        
        guard let url = URL(string: urlLink) else {
            self.delegate?.catchedError()
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.catchedError()
                print(error!.localizedDescription)
            }
            
            guard let recData = data else {
                self.delegate?.catchedError()
                return
            }
            
             DispatchQueue.main.async {
            
            do {
                let jsonData = try JSONDecoder().decode(JsonDataStruct.self, from: recData)
                var minTemp = ""
                var maxTemp = ""
                
                if let tempMin = jsonData.main.temp_min {
                    minTemp = String(Int(tempMin - 274.15))
                }
                
                if let tempMax = jsonData.main.temp_max {
                    maxTemp = String(Int(tempMax - 274.15))
                }
                
                if minTemp == "" || maxTemp == "" {
                    self.delegate?.catchedError()
                } else {
                    self.delegate?.newInfo(minTemp: minTemp, maxTemp: maxTemp)
                }

            } catch {
                self.delegate?.catchedError()
                }
            }
            }.resume()
    }
}
