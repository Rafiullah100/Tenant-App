//
//  NewTaskTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit

class MaintenaceTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        byLabel.text = LocalizationKeys.posted.rawValue.localizeString()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
    

