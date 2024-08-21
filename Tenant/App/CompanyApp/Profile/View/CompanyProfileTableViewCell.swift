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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var branch: CompanyBranch?{
        didSet{
            var name = branch?.name ?? ""
            var district = branch?.district ?? ""
            var city = branch?.city ?? ""
            var contact = branch?.contact ?? ""
            branchlabel.text = "\(name), \(district), \(city), \(contact)"
        }
    }
}
