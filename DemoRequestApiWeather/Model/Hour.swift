//
//  Hour.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 17/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import Foundation

class Hour {
    var time: String
    var tempC: String
    var urlIcon: String
    
    init?(json: JSON) {
        guard let time = json["time"] as? String else { return nil }
        guard let tempC = json["tempC"] as? String else { return nil }
        guard let weatherIconUrl = json["weatherIconUrl"] as? [JSON] else { return nil }
        guard let urlIcon = weatherIconUrl[0]["value"] as? String else {return nil}
        
        self.time = time
        self.tempC = tempC
        self.urlIcon = urlIcon
    }
    
}


