//
//  WorkerTableViewCell.swift
//  Worker
//
//  Created by Ngc on 10/07/2024.
//

import UIKit
import SDWebImage
class WorkerTableViewCell: UITableViewCell {
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var assignedLabel: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var byLbl: UILabel!
    @IBOutlet weak var maintananceLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var postedTimeLbl: UILabel!
    @IBOutlet weak var assignedTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        byLabel.text = LocalizationKeys.by.rawValue.localizeString()
        scheduleLabel.text = LocalizationKeys.scheduleMain.rawValue.localizeString()
        assignedLabel.text = LocalizationKeys.assignedOn.rawValue.localizeString()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var complaint: WorkersRow? {
        didSet{
            titleLbl.text = complaint?.title?.capitalized
            postedTimeLbl.text = Helper.shared.dateFormate(dateString: complaint?.timestamp ?? "")
            assignedTimeLbl.text = Helper.shared.dateFormate(dateString: complaint?.workerAssignedDatetime ?? "")
            maintananceLbl.text = Helper.shared.dateFormate(dateString: complaint?.workerAssignedDatetime ?? "")

            let status = Helper.shared.getComplaintStatus(ownerApproval: complaint?.ownerApproval, companyApproval: complaint?.companyApproval, taskComplete: complaint?.taskComplete, tenantApproval: complaint?.tenantApproval, workerID: ((complaint?.workerID) != nil) ? 1 : 0)
            statusLbl.text = status.0
            colorView.backgroundColor = status.1.color
            byLbl.text = "\(complaint?.tenant?.name ?? "") - \(complaint?.tenant?.contact ?? "")"
        }
    }
    
}
    

