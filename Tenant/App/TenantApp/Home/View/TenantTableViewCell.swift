//
//  TenantHomeTableViewCell.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit

class TenantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var complaintLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var complaintIdLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        containerView.clipsToBounds = true
        
        complaintLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.posted.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var complaint: TenantComplaintsRow? {
        didSet{
            titleLbl.text = complaint?.title
            complaintIdLbl.text = "\(complaint?.id ?? 0)"
            postDate.text = Helper.shared.dateFormate(dateString: complaint?.timestamp ?? "")
        }
    }
    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
