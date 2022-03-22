//
//  RoomsTableViewCell.swift
//  Directory App
//
//  Created by SAISURAJ on 3/18/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {

    @IBOutlet weak var roomAvailabilty: UILabel!
    
    @IBOutlet weak var roomOccupanyMax: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var modelRooms:RoomsModel?{
        didSet{
            roomsConfig()
        }
    }
    func roomsConfig(){
        if modelRooms?.isOccupied == true{
          roomAvailabilty.text = "Rooms are Occupied"
        }
        else{
          roomAvailabilty.text = "Rooms are not Occupied"
        }
        roomOccupanyMax.text = "Max Occupancy" + " " + String(modelRooms!.maxOccupancy!)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
