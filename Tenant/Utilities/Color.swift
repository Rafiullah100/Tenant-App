//
//  Color.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit
enum CustomColor {
    case appColor
    case grayColor
    case redColor
    case blueColor
    case greenColor
    case categoryGrayColor
    case buttonSelectedColor
    case buttonUnselectedColor
}

extension CustomColor {
    var color: UIColor {
        switch self {
        case .appColor:
            return UIColor(hex: 0x3B72C5, alpha: 1.0)
        case .grayColor:
            return UIColor(hex: 0xD8D8D8, alpha: 1.0)
        case .redColor:
            return UIColor(hex: 0xEB4335)
        case .blueColor:
            return UIColor(hex: 0x3B72C5)
        case .greenColor:
            return UIColor(hex: 0x3BC551)
        case .categoryGrayColor:
            return UIColor(hex: 0x797979)
        case .buttonSelectedColor:
            return UIColor(hex: 0x96B2DC, alpha: 0.5)
        case .buttonUnselectedColor:
            return UIColor(hex: 0xE4E4E4, alpha: 0.6)
        }
    }
}
