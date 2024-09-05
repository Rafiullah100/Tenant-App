//
//  teamCardCollectionViewCell.swift
//  Raabt2
//
//  Created by Ngc on 11/07/2024.
//

import UIKit

class CompanyWorkerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tradesLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var phNoLbl: UILabel!
    @IBOutlet weak var tradeNameLabel: UILabel!
    
    @IBOutlet weak var branchLabel: UILabel!
    static let identifier = "teamCardCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        tradesLabel.text = LocalizationKeys.trade.rawValue.localizeString()
        branchLabel.text = LocalizationKeys.branch.rawValue.localizeString()
    }

    
    static func nib()->UINib{
        return UINib(nibName: "WorkerCollectionViewCell", bundle: nil)
    }
    
    var worker: CompanyWorkerRow? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (worker?.photo ?? "")), placeholderImage: UIImage(named: "placeholder"))

            titleLbl.text = worker?.name
            var skills = [String]()
            
            worker?.workerSkills?.forEach({ skill in
                skills.append(skill.skill?.title ?? "")
            })
            let skillString = skills.joined(separator: ", ")
            tradeNameLabel.text = skillString
            branchNameLbl.text = worker?.branch?.name
            phNoLbl.text = worker?.contact
        }
    }

}

