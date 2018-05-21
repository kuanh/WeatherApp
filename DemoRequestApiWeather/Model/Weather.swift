//
//  Weather.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 15/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<AnyHashable, Any>

class Weather {
    var name : String
    var country: String
    var localtime: String
    var statusText: String
    var temp_c : Int
    var forecastday: [ForeCastDay] = []
    
    init?(json: JSON) {
        guard let locationJson = json["location"] as? JSON else {return nil}
        guard let currentJson = json["current"] as? JSON else {return nil}
        guard let forecastJson = json["forecast"] as? JSON else {return nil}
        
        guard let name = locationJson["name"] as? String else {return nil}
        guard let country = locationJson["country"] as? String else {return nil}
        guard let localtime = locationJson["localtime"] as? String else {return nil}
        
        guard let temp_c = currentJson["temp_c"] as? Int else {return nil}
        guard let condition = currentJson["condition"] as? JSON else { return nil }
        
        guard let statusText = condition["text"] as? String else { return nil }
        
        guard let forecast = forecastJson["forecastday"] as? [JSON] else {return nil}
        
        self.name = name
        self.country = country
        self.localtime = localtime
        self.temp_c = temp_c
        self.statusText = statusText
        
        for forecastdays in forecast {
            if let days = ForeCastDay(json: forecastdays) {
                self.forecastday.append(days)
            }
        }
    }
}


