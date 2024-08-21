//
//  StatusDoneCollectionViewCell.swift
//  Raabt
//
//  Created by Ngc on 01/07/2024.
//

import UIKit
import SDWebImage

class StatusDoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView:UIImageView!
    static let identifier = "StatusDoneCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func configure(with image: String){
        imageView.sd_setImage(with: URL(string: Route.baseUrl + image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    static func nib()->UINib{
        return UINib(nibName: "StatusDoneCollectionViewCell", bundle: nil)
    }
}
