//
//  PhotoViewerCollectionViewCell.swift
//  Tenant
//
//  Created by MacBook Pro on 9/16/24.
//

import UIKit
import SDWebImage
class PhotoViewerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configure(with image: String?){
        print(Route.baseUrl + (image ?? ""))
        imgView.sd_setImage(with: URL(string: Route.baseUrl + (image ?? "")), placeholderImage: UIImage(named: "placeholder"))
    }
    
    public func viewAddComplaintPhoto(photo: UIImage?){
        imgView.image = photo
    }

}
