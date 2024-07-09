//
//  ComplainDetailCollectionViewCell.swift
//  Raabt
//
//  Created by Ngc on 28/06/2024.
//

import UIKit

class ComplainDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView:UIImageView!
    static let identifier = "ComplainDetailCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func configure(with image:UIImage){
        imageView.image = image
    }
    
    static func nib()->UINib{
        return UINib(nibName: "ComplainDetailCollectionViewCell", bundle: nil)
    }

}
