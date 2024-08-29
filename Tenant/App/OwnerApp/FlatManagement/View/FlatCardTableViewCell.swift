//
//  FlatCardTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class FlatCardTableViewCell: UITableViewCell {

    @IBOutlet weak var flatNumberLbl: UILabel!
    
    @IBOutlet weak var noTenantView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
