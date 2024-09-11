//
//  CompanyWorkerTableViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 9/11/24.
//

import UIKit
import SDWebImage
class CompanyWorkerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        tradeLabel.text = LocalizationKeys.trade.rawValue.localizeString()
        branchLabel.text = LocalizationKeys.branch.rawValue.localizeString()
    }

    @IBOutlet weak var phoneLabell: UILabel!
    @IBOutlet weak var branchValueLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var tradeValueLabel: UILabel!
    @IBOutlet weak var tradeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var worker: CompanyWorkerRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (worker?.photo ?? "")), placeholderImage: UIImage(named: "User"))

            nameLabel.text = worker?.name
            var skills = [String]()
            
            worker?.workerSkills?.forEach({ skill in
                skills.append(skill.skill?.title ?? "")
            })
            let skillString = skills.joined(separator: ", ")
            tradeValueLabel.text = skillString
            branchValueLabel.text = worker?.branch?.name
            phoneLabell.text = worker?.contact
        }
    }
    
}
