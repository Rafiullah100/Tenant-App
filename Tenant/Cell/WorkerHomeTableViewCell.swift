//
//  WorkerHomeTableViewCell.swift
//  Worker
//
//  Created by Ngc on 10/07/2024.
//

import UIKit

class WorkerHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var byLbl: UILabel!
    @IBOutlet weak var maintananceLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var postedTimeLbl: UILabel!
    @IBOutlet weak var assignedTimeLbl: UILabel!
    
    
    public func workerHome(WorkerHome: workDetails)  {
        titleLbl.text = WorkerHome.title
        byLbl.text = WorkerHome.by
        statusLbl.text = WorkerHome.status
        maintananceLbl.text = WorkerHome.maintanance
        postedTimeLbl.text = WorkerHome.postedDate
        assignedTimeLbl.text = WorkerHome.assignedDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
    

