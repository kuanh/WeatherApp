//
//  TableViewCell.swift
//  DemoRequestApiWeather
//
//  Created by KuAnh on 17/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbDayOfWeek: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var lbMaxTempC: UILabel!
    @IBOutlet weak var lbMinTempC: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
