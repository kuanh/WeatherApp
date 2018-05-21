//
//  DataService.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 15/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

class DataService {
    static let shared = DataService()
    
    var weather: Weather?
    
    func loadWeather() {
        let urlString = "http://api.apixu.com/v1/forecast.json?key=6170cea472b94d109f334857181605&q=Hanoi&days=7&lang=vi"
        
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let aData = data else { return }
                
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? JSON else { return }
                    self.weather = Weather(json: jsonObject)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name.init("update"), object: nil)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
    func filterHour(hours: inout [Hour]) -> [Hour] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let currentTime = formatter.string(from: Date())
        hours.remove(at: 0)
        hours = hours.filter({ hour -> Bool in
            formatter.dateFormat = "HH:mm"
            let a = formatter.date(from: hour.time.coverToDate())
            formatter.dateFormat = "HH"
            let timeC = formatter.string(from: a!)
            return Int(timeC)! >= Int(currentTime)!
        })
        
        return hours
        
    }
    
    func load24h(complete: @escaping ([Hour])->Void)  {
        let urlString = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=4e86afda7436487885575310181705&q=Hanoi&format=json&num_of_days=1&date=today&fx=yes&cc=yes&mca=yes&fx24=yes&includelocation=yes&show_comments=yes&tp=1&showlocaltime=yes&lang=vi"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        var hours : [Hour] = []
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }

                guard let aData = data else { return }

                do{
                    guard let jsonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? JSON else { return }
                    guard let data = jsonObject["data"] as? JSON,
                        let weather = data["weather"] as? [JSON],
                        let hourly = weather[0]["hourly"] as? [JSON]
                        else { return }
                    
                    for hourJson in hourly {
                        if let hour = Hour(json: hourJson) {
                            
                            hours.append(hour)
                        }
                    }
                    
                    hours = self.filterHour(hours: &hours)
                    
                    DispatchQueue.main.async {
                        complete(hours)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
    
}

