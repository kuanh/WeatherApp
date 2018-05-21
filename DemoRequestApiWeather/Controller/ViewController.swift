//
//  ViewController.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 15/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

enum UrlString :String {
    case partlyCloudy = "https://j.gifs.com/MQV741.gif"
    case thunder1 = "https://media.giphy.com/media/fAV73wP5H7xN6/giphy.gif"
    case rainThunder = "https://j.gifs.com/7LBVpO.gif"
    case rainShower = "https://j.gifs.com/yrv2XR.gif"
    func showBackground() ->String { return self.rawValue }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var lbTempC: UILabel!
    @IBOutlet weak var maxTempC: UILabel!
    @IBOutlet weak var minTempC: UILabel!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var loadGif: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    
    var arrayForeCast : [ForeCastDay] = []
    var hour : [Hour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: Notification.Name.init("update"), object: nil)
        
        DataService.shared.loadWeather()
        DataService.shared.load24h { [unowned self] (hour) in
            self.hour = hour
            self.collectionView.reloadData()
        }
        
    }
    
    func loadBackgroundImage(urlString: String) {
        if let url = URL(string: urlString){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.loadGif.image = UIImage.animatedImage(data: data)
                    }
                }
            }
        }
    }
    
    @objc func getData() {
        guard let weather = DataService.shared.weather else { return }
        
        
        lbName.text = "Hà Nội"
        lbTempC.text = "\(weather.temp_c)°"
        arrayForeCast = weather.forecastday
        lbText.text = weather.statusText
        
        lbDay.text =  arrayForeCast[0].dateTime.getDayOfWeek()  + "     " + "Hom nay"
        maxTempC.text = String(Int(arrayForeCast[0].maxtemp_c))
        minTempC.text = String(Int(arrayForeCast[0].mintemp_c))
        if lbText.text == "Có Mây" {
            loadBackgroundImage(urlString: UrlString.partlyCloudy.rawValue)
        } else if lbText.text == "Mưa rào nhẹ" || lbText.text == "Mưa lả tả gần đó" {
            loadBackgroundImage(urlString: UrlString.rainShower.rawValue)
        } else if lbText.text == "Các cơn giông tố nổi lên gần đó" {
            loadBackgroundImage(urlString: UrlString.thunder1.rawValue)
        } else if lbText.text == "Mưa nhẹ lả tả trong khu vực có sấm sét" {
            loadBackgroundImage(urlString: UrlString.rainThunder.rawValue)
        }
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayForeCast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.lbDayOfWeek.text = arrayForeCast[indexPath.row].dateTime.getDayOfWeek()
        cell.iconView.getImage(urlString: "https:\(arrayForeCast[indexPath.row].icon)")
        cell.lbMaxTempC.text = String(Int(arrayForeCast[indexPath.row].maxtemp_c))
        cell.lbMinTempC.text = String(Int(arrayForeCast[indexPath.row].mintemp_c))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hour.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.lbHour.text = indexPath.row == 0 ? "Bay gio" : hour[indexPath.row].time.coverToDate()
        cell.imgIcon.getImage(urlString: hour[indexPath.row].urlIcon)
        cell.lbTempC.text = hour[indexPath.row].tempC + "º"
        
        
        return cell
    }
}



