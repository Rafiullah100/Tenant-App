//
//  NewTaskTableViewCell.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit

class CompanyNewTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
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
    
    var complaint: CompanyComplaintsRow? {
        didSet{
            titleLbl.text = complaint?.title?.capitalized
//            addressLabel.text = complaint?.tenantDistrict
            postDate.text = Helper.shared.dateFormate(dateString: complaint?.timestamp ?? "")
            addressLabel.text = "\(complaint?.tenant?.name ?? "") - \(complaint?.tenant?.contact ?? "")"
            let status = Helper.shared.getComplaintStatus(ownerApproval: complaint?.ownerApproval, companyApproval: complaint?.companyApproval, taskComplete: complaint?.taskComplete, tenantApproval: complaint?.tenantApproval, workerID: ((complaint?.workerID) != nil) ? 1 : 0)
            statusLbl.text = status.0
            colorView.backgroundColor = status.1.color
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
    

