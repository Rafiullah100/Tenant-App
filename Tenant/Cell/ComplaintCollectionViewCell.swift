//
//  ComplaintCollectionViewCell.swift
//  Raabt
//
//  Created by Ngc on 28/06/2024.
//

import UIKit

class ComplaintCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView:UIImageView!
    static let identifier = "ComplaintCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public func configure(with image:UIImage){
        imageView.image = image
    }
    
    static func nib()->UINib{
        return UINib(nibName: "ComplaintCollectionViewCell", bundle: nil)
    }

}
