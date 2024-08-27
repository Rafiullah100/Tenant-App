//
//  PropertyTableViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var property: PropertiesRow? {
        didSet{
            let buildingType = property?.buildingType?.capitalized ?? ""

            let buildingNo = property?.buildingNo ?? ""
            let district = property?.district ?? ""
            let city = property?.city ?? ""
            
            self.label.text = "\(buildingType) \(buildingNo), \(city), \(district)"
        }
    }
}
