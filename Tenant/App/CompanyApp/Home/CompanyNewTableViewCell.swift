//
//  NewTaskTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit

class OwnerHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        byLabel.text = LocalizationKeys.by.rawValue.localizeString()
        
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
    

