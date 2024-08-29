//
//  FlatCardTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class CompanyCardTableViewCell: UITableViewCell {

    var assign: (() -> Void)?

    @IBOutlet weak var assignButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func assignBtnAction(_ sender: Any) {
        assign?()
    }
}
