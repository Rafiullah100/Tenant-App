//
//  FlatCardTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class BothPropertyTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var flatNumberLbl: UILabel!
    
    @IBOutlet weak var buttonLabel: UILabel!
    var selectAsYourHome: (() -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectAsYourHome(_ sender: Any) {
        selectAsYourHome?()
    }
    var property: PropertiesRow? {
        didSet{
            let buildingType = property?.buildingType?.capitalized ?? ""
            buttonView.isHidden = property?.buildingType == "building" ? true : false
            let buildingNo = property?.buildingNo ?? ""
            let district = property?.district ?? ""
            let city = property?.city ?? ""
            
            self.flatNumberLbl.text = "\(buildingType) \(buildingNo), \(city), \(district)"
        }
    }
}
