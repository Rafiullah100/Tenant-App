//
//  TenantMngmentTableViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 9/11/24.
//

import UIKit
import SDWebImage
class TenantMngmentTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var flatNoLbl: UILabel!
    @IBOutlet weak var phNoLbl: UILabel!
    
    @IBOutlet weak var assignedToLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        bgView.clipsToBounds = true
        assignedToLabel.text = LocalizationKeys.assignTo.rawValue.localizeString()
    }
    var delete: (() -> Void)?

 
    static func nib()->UINib{
        return UINib(nibName: "TenantCollectionViewCell", bundle: nil)
    }
    var tenants: PropertyTenantsFlat?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (tenants?.ownersTenants?.profileImage ?? "")), placeholderImage: UIImage(named: "User"))
            titleLbl.text = tenants?.ownersTenants?.name?.capitalized
            flatNoLbl.text = "Flat \(tenants?.flatNo ?? "")"
            phNoLbl.text = tenants?.ownersTenants?.contact ?? ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delete?()

    }
}
