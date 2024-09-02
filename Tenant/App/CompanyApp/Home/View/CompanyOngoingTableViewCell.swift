//
//  OngoingMaintenanceTableViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 7/9/24.
//

import UIKit

class CompanyOngoingTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var assignedLbl: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var assignedtoLabel: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        byLabel.text = LocalizationKeys.by.rawValue.localizeString()
        assignedtoLabel.text = LocalizationKeys.assignTo.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var complaint: CompanyComplaintsRow? {
        didSet{
            titleLbl.text = complaint?.title
            postDate.text = Helper.shared.dateFormate(dateString: complaint?.timestamp ?? "")
            let status = Helper.shared.getComplaintStatus(ownerApproval: complaint?.ownerApproval, companyApproval: complaint?.companyApproval, taskComplete: complaint?.taskComplete, tenantApproval: complaint?.tenantApproval, workerID: ((complaint?.workerID) != nil) ? 1 : 0)
            
            statusLbl.text = status.0
            colorView.backgroundColor = status.1.color
            addressLabel.text = "\(complaint?.tenant?.name ?? "") - \(complaint?.tenant?.contact ?? "")"
            assignedLbl.text = "\(complaint?.tenant?.name ?? "") - \(complaint?.tenant?.contact ?? "")"
        }
    }
    
}
