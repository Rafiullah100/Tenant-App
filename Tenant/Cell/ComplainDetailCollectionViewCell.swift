//
//  ComplainDetailCollectionViewCell.swift
//  Raabt
//
//  Created by Ngc on 28/06/2024.
//

import UIKit
import SDWebImage
class ComplainDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView:UIImageView!
    static let identifier = "ComplainDetailCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func configure(with image: String){
        imageView.sd_setImage(with: URL(string: Route.baseUrl + image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    static func nib()->UINib{
        return UINib(nibName: "ComplainDetailCollectionViewCell", bundle: nil)
    }

}
