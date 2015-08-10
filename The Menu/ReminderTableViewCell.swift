//
//  ReminderTableViewCell.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/9/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var meal: Meal? {
        didSet {
            update()
        }
    }
    
    private func update() {
        mealLabel.text = Utils.getTime(meal!.time)
        locationLabel.text = meal!.toPlace.name
        dayLabel.text = Utils.getDay(meal!.day)
        placeLatitude = meal!.toPlace.latitude as? Double
        placeLongitude = meal!.toPlace.longitude as? Double
    }
    
    var placeLatitude: Double?
    var placeLongitude: Double?

    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var mealLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
