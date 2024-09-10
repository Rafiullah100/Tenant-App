//
//  UserDefaults+Extension.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/23/23.
//

import Foundation



extension UserDefaults{
    enum userdefaultsKey: String {
        case selectedLanguage
        case name
        case email
        case mobile
        case profileImage
        case uuid
        case token
        case isLogin
        case languageCode
        case isRTL
        case about
        case newsID
        case isOpenFromLink
        case appleSigninIdentifier
        case appleEmail
        case userID
        case userType
        case propertyIDIfTenant
        case flatIDIfTenant
        case currentHome
    }
    
    var selectedLanguage: String?  {
        get {
            value(forKey: userdefaultsKey.selectedLanguage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.selectedLanguage.rawValue)
        }
    }
    
    var name: String?  {
        get {
            value(forKey: userdefaultsKey.name.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.name.rawValue)
        }
    }
    
    var email: String?  {
        get {
            value(forKey: userdefaultsKey.email.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.email.rawValue)
        }
    }
    
    var mobile: String?  {
        get {
            value(forKey: userdefaultsKey.mobile.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.mobile.rawValue)
        }
    }
    
    var profileImage: String?  {
        get {
            value(forKey: userdefaultsKey.profileImage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.profileImage.rawValue)
        }
    }
    
    var token: String?  {
        get {
            value(forKey: userdefaultsKey.token.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.token.rawValue)
        }
    }
    
    var uuid: String?  {
        get {
            value(forKey: userdefaultsKey.uuid.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.uuid.rawValue)
        }
    }
    
    var propertyIDIfTenant: Int?  {
        get {
            value(forKey: userdefaultsKey.propertyIDIfTenant.rawValue) as? Int
        }
        set {
            set(newValue, forKey: userdefaultsKey.propertyIDIfTenant.rawValue)
        }
    }
    
    var isLogin: Bool?  {
        get {
            value(forKey: userdefaultsKey.isLogin.rawValue) as? Bool
        }
        set {
            set(newValue, forKey: userdefaultsKey.isLogin.rawValue)
        }
    }
    
    var languageCode: String?{
        get {
            value(forKey: userdefaultsKey.languageCode.rawValue) as? String
        }
        set{
            set(newValue, forKey: userdefaultsKey.languageCode.rawValue)
        }
    }
    
    var isRTL: Int?{
        get {
            value(forKey: userdefaultsKey.isRTL.rawValue) as? Int
        }
        set{
            set(newValue, forKey: userdefaultsKey.isRTL.rawValue)
        }
    }
    
    var about: String?  {
        get {
            value(forKey: userdefaultsKey.about.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.about.rawValue)
        }
    }
    
    var newsID: String?  {
        get {
            value(forKey: userdefaultsKey.newsID.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.newsID.rawValue)
        }
    }
    
    var isOpenFromLink: Bool?  {
        get {
            value(forKey: userdefaultsKey.isOpenFromLink.rawValue) as? Bool
        }
        set {
            set(newValue, forKey: userdefaultsKey.isOpenFromLink.rawValue)
        }
    }
    
    var appleSigninIdentifier: String?  {
        get {
            value(forKey: userdefaultsKey.appleSigninIdentifier.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.appleSigninIdentifier.rawValue)
        }
    }
    
    var appleEmail: String?  {
        get {
            value(forKey: userdefaultsKey.appleEmail.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.appleEmail.rawValue)
        }
    }
    
    var userID: Int?  {
        get {
            value(forKey: userdefaultsKey.userID.rawValue) as? Int
        }
        set {
            set(newValue, forKey: userdefaultsKey.userID.rawValue)
        }
    }
    
    var userType: String?  {
        get {
            value(forKey: userdefaultsKey.userType.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.userType.rawValue)
        }
    }
    
    var flatIDIfTenant: Int?  {
        get {
            value(forKey: userdefaultsKey.flatIDIfTenant.rawValue) as? Int
        }
        set {
            set(newValue, forKey: userdefaultsKey.flatIDIfTenant.rawValue)
        }
    }
    
    var currentHome: String?  {
        get {
            value(forKey: userdefaultsKey.currentHome.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.currentHome.rawValue)
        }
    }
}

extension UserDefaults {
    class func clean(exceptKeys keysToKeep: [String] = []) {
        guard let aValidIdentifier = Bundle.main.bundleIdentifier else { return }
        let defaults = UserDefaults.standard
        var valuesToKeep: [String: Any] = [:]
        for key in keysToKeep {
            if let value = defaults.value(forKey: key) {
                valuesToKeep[key] = value
            }
        }
        defaults.removePersistentDomain(forName: aValidIdentifier)
        for (key, value) in valuesToKeep {
            defaults.setValue(value, forKey: key)
        }
        defaults.synchronize()
    }
}
