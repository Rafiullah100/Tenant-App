//
//  TenantCollectionViewCell.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class TenantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var flatNoLbl: UILabel!
    @IBOutlet weak var phNoLbl: UILabel!
    
    @IBOutlet weak var assignedToLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.clipsToBounds = true
        assignedToLabel.text = LocalizationKeys.assignTo.rawValue.localizeString()

    }

    static func nib()->UINib{
        return UINib(nibName: "TenantCollectionViewCell", bundle: nil)
    }
}

