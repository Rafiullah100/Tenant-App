//
//  Helper.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit
import CoreLocation
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
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let outputDateFormat = "MMM d, yyyy, h:mm a"
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.locale = Locale(identifier: "en_PK")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Parse the input as UTC time

        if let inputDate = dateFormatter.date(from: dateString) {
            
            dateFormatter.dateFormat = outputDateFormat
            dateFormatter.timeZone = TimeZone.current
            let outputDateString = dateFormatter.string(from: inputDate)
            
            print(outputDateString)
            return outputDateString
        } else {
            return ""
        }

    }
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var formattedString = ""
        
        let maxLength = min(phoneNumber.count, 10)
        
        for (index, digit) in phoneNumber.prefix(maxLength).enumerated() {
            if index == 0 {
                formattedString += "0"
            } else if index == 1 {
                formattedString += "5"
            } else if index == 2 {
                formattedString += String(digit) + " "
            } else if index == 5 {
                formattedString += String(digit) + " "
            } else {
                formattedString += String(digit)
            }
        }
        return formattedString
    }
    
    func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "yyyy-MM-dd"
        let myStringDate = formatter.string(from: yourDate!)
        return myStringDate
    }
    
    func convertTo24HourFormat(time12: String) -> String? {
        print(time12)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"

        if let date = dateFormatter.date(from: time12) {
            dateFormatter.dateFormat = "HH:mm:ss" // Format for 24-hour time with minutes
            return dateFormatter.string(from: date)
        } else {
            return nil // Return nil if the input is invalid
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
    
    func userType() -> UserType {
        let user = UserDefaults.standard.userType
        if user == UserType.company.rawValue{
            return .company
        }
        else if user == UserType.tenant.rawValue{
            return .tenant
        }
        else if user == UserType.worker.rawValue{
            return .worker
        }
        else if user == UserType.owner.rawValue{
            return .owner
        }
        return .tenant
    }
    
    func getComplaintStatus(
        ownerApproval: Int?,
        companyApproval: Int?,
        taskComplete: Int?,
        tenantApproval: Int?,
        workerID: Int) -> (String, CustomColor) {
            if ownerApproval == 0 {
                if self.userType() == .owner{
                    return (LocalizationKeys.yourApprovalIsPending.rawValue.localizeString(), CustomColor.redColor)
                }
                else{
                    return (LocalizationKeys.ApprovalPendingfromOwner.rawValue.localizeString(), CustomColor.redColor)
                }
            }
            else if ownerApproval == 2{
                if self.userType() == .owner{
                    return (LocalizationKeys.rejectedByYou.rawValue.localizeString(), CustomColor.redColor)
                }
                else{
                    return (LocalizationKeys.RejectedbyOwner.rawValue.localizeString(), CustomColor.redColor)
                }
            }
            else if ownerApproval == 1 && companyApproval == 0{
                if self.userType() == .company {
                    return (LocalizationKeys.yourAcceptanceIsPending.rawValue.localizeString(), CustomColor.redColor)
                }
                else{
                    return (LocalizationKeys.AcceptancePendingfromMaintenanceCompany.rawValue.localizeString(), CustomColor.redColor)
                }
            }
            else if ownerApproval == 1 && companyApproval == 2{
                if self.userType() == .company{
                    return (LocalizationKeys.rejectedByYou.rawValue.localizeString(), CustomColor.redColor)
                }
                else{
                    return (LocalizationKeys.RejectedbyCompany.rawValue.localizeString(), CustomColor.redColor)
                }
            }
            else if ownerApproval == 1 && workerID == 0 && taskComplete == 0{
                return (LocalizationKeys.Notassigntoworker.rawValue.localizeString(), CustomColor.redColor)
            }
            else if workerID != 0 && taskComplete == 0{
                return (LocalizationKeys.Workinprogress.rawValue.localizeString(), CustomColor.blueColor)
            }
            else if taskComplete == 1 && tenantApproval == 0{
                return (LocalizationKeys.WorkDoneWaitingforConfirmation.rawValue.localizeString(), CustomColor.greenColor)
            }
            else if tenantApproval == 1{
                return (LocalizationKeys.WorkdoneApproved.rawValue.localizeString(), CustomColor.greenColor)
            }
            return ("", CustomColor.redColor)
        }
    
    func getCoordinates(for postalCode: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(postalCode) { placemarks, error in
            guard error == nil else {
                print("Geocoding error: \(error!.localizedDescription)")
                completion(nil)
                return
            }

            if let placemark = placemarks?.first, let location = placemark.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
    }
}



