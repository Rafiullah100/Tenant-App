//
//  TradesCollectionViewCell.swift
//  Raabt2
//
//  Created by Ngc on 19/07/2024.
//

import UIKit

class AddWorkerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var checkView: UIView!
    
    @IBOutlet weak var selectedBtn: UIButton!
    @IBOutlet weak var tradesTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var isChecked: Bool = false {
        didSet {
            checkView.backgroundColor = isChecked ? CustomColor.greenColor.color : UIColor.white
            checkView.borderWidth = isChecked ? 0 : 1
        }
    }
    
    public func configure(with tradeTitle:String){
        tradesTitleLbl.text = tradeTitle
    }
}
