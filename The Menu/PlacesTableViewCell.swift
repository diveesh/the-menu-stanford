//
//  PlacesTableViewCell.swift
//  The Menu
//
//  Created by Diveesh Singh on 3/6/15.
//  Copyright (c) 2015 Diveesh Singh. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var place: Place? {
        didSet {
            update()
        }
    }
    
    private func update() {
        placeLabel.text = place!.name
        placeImage.image = UIImage(named: place!.name)
    }
    
    @IBOutlet weak var placeLabel: UILabel!

    @IBOutlet weak var placeImage: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
