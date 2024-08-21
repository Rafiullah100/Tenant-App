//
//  ContactPersonTableViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 7/11/24.
//

import UIKit
import SDWebImage
class ContactPersonTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var contact: ComplaintContact? {
        didSet{
            self.contactLabel.text = contact?.contact
            self.nameLabel.text = contact?.title
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (contact?.image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
