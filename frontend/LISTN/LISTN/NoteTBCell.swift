//
//  NoteTBCell.swift
//  
//
//  Created by Joshua Kuan on 29/04/2018.
//

import UIKit

class NoteTBCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
