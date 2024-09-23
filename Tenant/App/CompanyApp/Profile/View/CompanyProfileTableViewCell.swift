//
//  CompanyProfileTableViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 7/9/24.
//

import UIKit

class CompanyProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var branchlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var indexPath: IndexPath?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var branch: CompanyBranch?{
        didSet{
            let name = branch?.name?.capitalized ?? ""
            let district = branch?.district?.capitalized ?? ""
            let city = branch?.city?.capitalized ?? ""
            let contact = branch?.contact ?? ""
            branchlabel.text = "\((indexPath?.row ?? 0) + 1). \(name), \(district), \(city), \(contact)"
        }
    }
}
