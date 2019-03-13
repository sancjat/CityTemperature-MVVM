//
//  TableCell.swift
//  CityTemperature
//
//  Created by Santosh Kumari on 11/03/19.
//  Copyright © 2019 Santosh Kumari. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var templabel: UILabel!
    @IBOutlet weak var cityname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
