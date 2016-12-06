//
//  FeedsTableViewCell.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 05.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var adressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
