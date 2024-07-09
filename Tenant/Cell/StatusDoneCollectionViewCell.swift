//
//  StatusDoneCollectionViewCell.swift
//  Raabt
//
//  Created by Ngc on 01/07/2024.
//

import UIKit

class StatusDoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView:UIImageView!
    static let identifier = "StatusDoneCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func configure(with image:UIImage){
        imageView.image = image
    }
    
    static func nib()->UINib{
        return UINib(nibName: "StatusDoneCollectionViewCell", bundle: nil)
    }
}
