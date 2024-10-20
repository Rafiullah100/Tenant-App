//
//  ServicsCollectionViewCell.swift
//  Raabt2
//
//  Created by Ngc on 10/07/2024.
//

import UIKit
import SDWebImage
class CompanyWorkerCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var servicesBgView: UIView!
    
    static let identifier = "ServicsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib()->UINib{
        return UINib(nibName: "CompanyWorkerCategoryCollectionViewCell", bundle: nil)
    }
    
    var skill: SkillRow?{
        didSet{
            imgView.sd_setImage(with: URL(string: skill?.imageUrl ?? ""), placeholderImage: UIImage(named: "PlaceholderImage"))
            titleLbl.text = skill?.title?.capitalized
        }
    }
}
