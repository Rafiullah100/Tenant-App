//
//  Helper.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit
//import MaterialComponents.MaterialTabs_TabBarView
//import SpinKit
enum NotificationObserverKeys: String {
   case category = "category_changes"
    case sourceChanges = "source_changes"
    case authorsChanges = "authors_changes"
}

public class Helper{
    static let shared = Helper()
    
    func dateFormate(dateString: String) -> String {
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let outputDateFormat = "dd MMMM yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let inputDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputDateFormat
            let outputDateString = dateFormatter.string(from: inputDate)
            print(outputDateString)
            return outputDateString
        } else {
            return ""
        }
    }
    
    func semantic(_ language: AppLanguage) -> UISemanticContentAttribute{
//        let language: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .arabic
        print(language)
        switch language {
        case .english:
            return .forceLeftToRight
        case .arabic:
            return .forceRightToLeft
        }
    }
    
    func isRTL() -> Bool{
        return UserDefaults.standard.isRTL == 1 ? true : false
    }
}


