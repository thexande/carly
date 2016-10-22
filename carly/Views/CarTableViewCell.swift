//
//  CarTableViewCell.swift
//  carly
//
//  Created by Alexander Murphy on 10/21/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import SwiftyJSON

class CarTableViewCell: UITableViewCell {
    var car: JSON?
    var carModel: String?
    
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carYearLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected 
//       self.carModelLabel.text = self.car
        

        self.carModelLabel.text = self.car?["make"].stringValue
        
    }
    
}
