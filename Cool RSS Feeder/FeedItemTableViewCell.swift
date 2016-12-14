//
//  FeedItemTableViewCell.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 06.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {

  @IBOutlet weak var bigLetterLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var adressTextField: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
