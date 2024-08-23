//
//  Constants.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import Foundation
import UIKit
//import Firebase
struct HowTo {
    let text1: String?
    let text2: String?
    let image: String?
}

struct Constants {
    static let noLoggin = "You're not loggin"
    static let appColor = #colorLiteral(red: 0.2705882353, green: 0.7882352941, blue: 0.9568627451, alpha: 1)
    static let fontName = "ebrima"
    static let fontNameBold = "Outfit-SemiBold"
    static var news = "news"
    static var opinion = "opinion"

    static let appBoldFont = UIFont(name: "ebrima-bold", size: 12.0)
    static let appRegularFont = UIFont(name: "ebrima", size: 12.0)
    
    static let timeSlotArray = [
        "9AM to 10AM",
        "10AM to 11AM",
        "11AM to 12AM",
        "12PM to 1PM",
        "1PM to 2PM",
        "2PM to 3PM",
        "3PM to 4PM",
        "4PM to 5PM",
        "5PM to 6PM"
    ]
}

enum UserType: String {
    case owner
    case tenant
    case company
    case worker
}

enum OtpType: String {
    case signin
    case signup
}

enum PropertyType {
    case building
    case villa

}

enum OwnerComplaintType {
    case new
    case ongoing
    case rejected
    case completed
}

enum SelfComplaintType {
    case new
    case history
}

enum CompanyComplaintType {
    case new
    case ongoing
    case completed
}

enum WorkerComplaintType {
    case new
    case completed
}


