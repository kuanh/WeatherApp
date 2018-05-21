//
//  ExtensionString.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 19/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    
    func getIcon(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

extension String {
    func getDayOfWeek() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: self)
        formatter.dateFormat = "eeee"
        let date = Date()
        let currentDate = formatter.string(from: date)
        let weekDay = formatter.string(from: todayDate!)
        return currentDate == weekDay ? weekDay : weekDay
    }
    
}

extension String {
    func coverToDate() -> String {
        var hour: String = ""
        switch self {
        case "0":
            hour = "00:00"
        case "100":
            hour = "01:00"
        case "200":
            hour = "02:00"
        case "300":
            hour = "03:00"
        case "400":
            hour = "04:00"
        case "500":
            hour = "05:00"
        case "600":
            hour = "06:00"
        case "700":
            hour = "07:00"
        case "800":
            hour = "08:00"
        case "900":
            hour = "09:00"
        case "1000":
            hour = "10:00"
        case "1100":
            hour = "11:00"
        case "1200":
            hour = "12:00"
        case "1300":
            hour = "13:00"
        case "1400":
            hour = "14:00"
        case "1500":
            hour = "15:00"
        case "1600":
            hour = "16:00"
        case "1700":
            hour = "17:00"
        case "1800":
            hour = "18:00"
        case "1900":
            hour = "19:00"
        case "2000":
            hour = "20:00"
        case "2100":
            hour = "21:00"
        case "2200":
            hour = "22:00"
        case "2300":
            hour = "23:00"
        default:
            break
        }
        return hour
    }
    
    func filterHour() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        var arrHour: [Int] = []
        var text = ""
        
        if self != "24" {
            formatter.dateFormat = "HH:mm"
            let a = formatter.date(from: self)
            formatter.dateFormat = "HH"
            let timeC = formatter.string(from: a!)
            arrHour.append(Int(timeC)!)
            
        } else {
            formatter.dateFormat = "HH"
            let currentTime = formatter.string(from: date)
            arrHour.append(Int(currentTime)!)
        }
        
        formatter.dateFormat = "HH"
        let currentTime = formatter.string(from: date)
        arrHour.remove(at: 0)
        let arrToday = arrHour.filter { $0 >= Int(currentTime)!}
        let arrTomorrow = arrHour.filter { $0 < Int(currentTime)!}
        let arr = arrToday + arrTomorrow
        for element in arr {
            text = String(element)
        }
        return text
    }
}
