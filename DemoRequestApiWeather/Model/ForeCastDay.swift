//
//  ForeCast.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 16/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import Foundation


class ForeCastDay {
    var dateTime: String
    var maxtemp_c: Double
    var mintemp_c: Double
    var status: String
    var icon: String
    
    init?(json: JSON) {
        guard let dateTime = json["date"] as? String else { return nil}
        guard let dayJson = json["day"] as? JSON else { return nil}
        
        guard let maxtemp_c = dayJson["maxtemp_c"] as? Double else { return nil}
        guard let mintemp_c = dayJson["mintemp_c"] as? Double else { return nil}
        
        guard let condition = dayJson["condition"] as? JSON else {return nil}
        
        guard let status = condition["text"] as? String else {return nil}
        guard let icon = condition["icon"] as? String else {return nil}
        
        self.dateTime = dateTime
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.status = status
        self.icon = icon
    }
}
