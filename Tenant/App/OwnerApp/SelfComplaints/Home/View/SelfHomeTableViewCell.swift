//
//  TenantHomeTableViewCell.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit

class SelfHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var complaintLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var complaintIdLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        containerView.clipsToBounds = true
        
        complaintLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.posted.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var complaint: TenantComplaintsRow? {
        didSet{
            titleLbl.text = complaint?.title
            complaintIdLbl.text = "\(complaint?.id ?? 0)"
            postDate.text = Helper.shared.dateFormate(dateString: complaint?.timestamp ?? "")
            let status = Helper.shared.getComplaintStatus(ownerApproval: complaint?.ownerApproval, companyApproval: complaint?.companyApproval, taskComplete: complaint?.taskComplete, tenantApproval: complaint?.tenantApproval, workerID: ((complaint?.workerID) != nil) ? 1 : 0)
            
            statusLbl.text = status.0
            colorView.backgroundColor = status.1.color
        }
    }
    
}

