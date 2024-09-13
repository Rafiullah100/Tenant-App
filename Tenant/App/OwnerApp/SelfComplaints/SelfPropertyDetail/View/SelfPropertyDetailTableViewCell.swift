//
//  HomeSelectionTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 22/07/2024.
//

import UIKit

class SelfPropertyDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var homeTypeLbl: UILabel!
    
    @IBOutlet weak var label: UILabel!
    //    public func homeInfo(homeType: homeType )  {
//        homeTypeLbl.text = homeType.type
//    }
    
    var selectAsYourHome: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectAsYourHome(_ sender: Any) {
        selectAsYourHome?()
    }
}
